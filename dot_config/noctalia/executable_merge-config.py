#!/usr/bin/env python3
"""Run `noctalia config export merged` and split it into source config files.

Requires tomlkit and Taplo (on PATH or installed by Neovim's Mason).
Use --dry-run to preview changes without writing files.
"""

import argparse
import os
import shutil
import subprocess
import tempfile
from collections.abc import Mapping
from copy import deepcopy
from difflib import unified_diff
from pathlib import Path
from typing import cast

import tomlkit
from tomlkit import TOMLDocument
from tomlkit.exceptions import ParseError
from tomlkit.items import Table


class Arguments(argparse.Namespace):
    config_dir: Path = Path(__file__).resolve().parent
    dry_run: bool = False


def load_toml(path: Path) -> TOMLDocument:
    try:
        return tomlkit.parse(path.read_text(encoding="utf-8"))
    except ParseError as error:
        raise ValueError(f"invalid TOML in {path}: {error}") from error


def export_merged() -> TOMLDocument:
    result = subprocess.run(
        ["noctalia", "config", "export", "merged"],
        capture_output=True,
        text=True,
        encoding="utf-8",
        check=False,
    )
    if result.returncode != 0:
        raise ValueError(
            f"Noctalia export failed ({result.returncode}): {result.stderr.strip()}"
        )
    try:
        return tomlkit.parse(result.stdout)
    except ParseError as error:
        raise ValueError(f"invalid TOML from Noctalia export: {error}") from error


def require_table(config: TOMLDocument | Table, key: str) -> Table:
    # Check tomlkit's untyped values before using them as tables.
    value = cast(Mapping[str, object], config).get(key)
    if not isinstance(value, Table):
        raise TypeError(f"missing or invalid table: {key}")
    return value


def build_outputs(merged: TOMLDocument, settings: TOMLDocument) -> dict[str, str]:
    """Keep local includes and move exported tables to their source files."""
    merged = deepcopy(merged)
    theme = require_table(merged, "theme")
    templates = require_table(theme, "templates")
    lockscreen = require_table(merged, "lockscreen_widgets")
    include = require_table(settings, "include")

    del theme["templates"]
    del merged["lockscreen_widgets"]
    if "include" in merged:
        del merged["include"]

    # Put local includes first, followed by the remaining exported settings.
    settings_output: dict[str, object] = {"include": include}
    settings_output.update(cast(Mapping[str, object], merged))
    outputs: dict[str, str] = {
        "configettings.toml": tomlkit.dumps(settings_output),
        "templates.toml": tomlkit.dumps({"theme": {"templates": templates}}),
        "modules/lockscreen.toml": tomlkit.dumps({"lockscreen_widgets": lockscreen}),
    }
    for name, content in outputs.items():
        try:
            _ = tomlkit.parse(content)
        except ParseError as error:
            raise ValueError(f"generated invalid TOML for {name}: {error}") from error
    return outputs


def format_outputs(outputs: dict[str, str], config_dir: Path) -> dict[str, str]:
    """Match Neovim's Taplo formatter with two-space indentation."""
    data_home = Path(os.environ.get("XDG_DATA_HOME", str(Path.home() / ".local/share")))
    taplo = shutil.which(
        "taplo", path=str(data_home / "nvim/mason/bin")
    ) or shutil.which("taplo")
    if taplo is None:
        raise ValueError("Taplo not found; install it with Mason or add it to PATH")

    formatted: dict[str, str] = {}
    for name, content in outputs.items():
        result = subprocess.run(
            [
                taplo,
                "format",
                "--stdin-filepath",
                str((config_dir / name).resolve()),
                "--option",
                "indent_string=  ",
                "-",
            ],
            input=content,
            capture_output=True,
            encoding="utf-8",
            cwd=config_dir,
            check=False,
        )
        if result.returncode != 0:
            raise ValueError(f"Taplo failed for {name}: {result.stderr.strip()}")
        formatted[name] = result.stdout
    return formatted


def atomic_write(path: Path, content: str) -> None:
    """Replace one file only after its contents have been written successfully."""
    path.parent.mkdir(parents=True, exist_ok=True)
    mode = path.stat().st_mode if path.exists() else 0o644
    temporary_path: Path | None = None
    try:
        with tempfile.NamedTemporaryFile(
            mode="w", encoding="utf-8", dir=path.parent, delete=False
        ) as temporary_file:
            temporary_path = Path(temporary_file.name)
            _ = temporary_file.write(content)
        os.chmod(temporary_path, mode)
        _ = temporary_path.replace(path)
    finally:
        if temporary_path is not None:
            temporary_path.unlink(missing_ok=True)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    _ = parser.add_argument(
        "--config-dir",
        type=Path,
        default=Arguments.config_dir,
        help="destination config directory (default: this script's directory)",
    )
    _ = parser.add_argument(
        "--dry-run", action="store_true", help="show a diff without writing files"
    )
    args = parser.parse_args(namespace=Arguments())

    try:
        outputs = build_outputs(
            export_merged(), load_toml(args.config_dir / "config.toml")
        )
        outputs = format_outputs(outputs, args.config_dir)
        for name, content in outputs.items():
            path = args.config_dir / name
            if args.dry_run:
                original = path.read_text(encoding="utf-8") if path.exists() else ""
                diff = unified_diff(
                    original.splitlines(keepends=True),
                    content.splitlines(keepends=True),
                    fromfile=str(path),
                    tofile=f"{path} (proposed)",
                )
                print("".join(diff), end="")
            else:
                atomic_write(path, content)
                print(f"updated {path}")
    except (OSError, ValueError) as error:
        parser.exit(1, f"error: {error}\n")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
