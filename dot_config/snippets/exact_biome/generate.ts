#!/usr/bin/env bun

import { existsSync } from 'node:fs';
import { mkdir, readFile, writeFile } from 'node:fs/promises';
import { resolve, dirname, join } from 'node:path';

type JsonValue =
  | string
  | number
  | boolean
  | null
  | JsonValue[]
  | { [key: string]: JsonValue };

type JsonObject = { [key: string]: JsonValue };

const DEFAULT_SNIPPETS_DIR = resolve(process.env.HOME ?? '', '.config/snippets/biome');
const DEFAULT_OUTPUT = 'biome.json';
const DEFAULT_BASE = 'base';
const PRESET_ALIASES: Record<string, string> = {
  typescript: 'base',
  typescriptreact: 'react',
  ts: 'base',
  tsx: 'react',
};

function isObject(value: JsonValue | undefined): value is JsonObject {
  return value !== null && typeof value === 'object' && !Array.isArray(value);
}

function deepMerge(base: JsonValue | undefined, override: JsonValue): JsonValue {
  if (isObject(base) && isObject(override)) {
    const merged: JsonObject = { ...base };

    for (const [key, value] of Object.entries(override)) {
      merged[key] = key in merged ? deepMerge(merged[key], value) : value;
    }

    return merged;
  }

  return override;
}

async function loadJson(path: string): Promise<JsonObject> {
  try {
    const content = await readFile(path, 'utf8');
    return JSON.parse(content) as JsonObject;
  } catch (error) {
    if (error instanceof Error) {
      throw new Error(`Failed to read ${path}: ${error.message}`);
    }

    throw error;
  }
}

async function resolveConfig(
  path: string,
  seen: Set<string>,
  options?: { includeExtends?: boolean },
): Promise<JsonObject> {
  const absolutePath = resolve(path);
  if (seen.has(absolutePath)) {
    return {};
  }

  seen.add(absolutePath);

  const data = await loadJson(absolutePath);
  let merged: JsonObject = {};
  const includeExtends = options?.includeExtends ?? true;

  if (includeExtends) {
    const extendsValue = data.extends;
    const extendsList =
      typeof extendsValue === 'string'
        ? [extendsValue]
        : Array.isArray(extendsValue)
          ? extendsValue.filter((item): item is string => typeof item === 'string')
          : [];

    for (const item of extendsList) {
      if (item === '//') {
        continue;
      }

      const extended = await resolveConfig(resolve(dirname(absolutePath), item), seen, options);
      merged = deepMerge(merged, extended) as JsonObject;
    }
  }

  const own: JsonObject = { ...data };
  delete own.extends;

  return deepMerge(merged, own) as JsonObject;
}

async function detectPresets(projectDir: string): Promise<string[]> {
  const packageJsonPath = join(projectDir, 'package.json');

  if (existsSync(packageJsonPath)) {
    const packageJson = await loadJson(packageJsonPath);
    const sections = [
      packageJson.dependencies,
      packageJson.devDependencies,
      packageJson.peerDependencies,
      packageJson.optionalDependencies,
    ];

    const deps = Object.assign(
      {},
      ...sections.filter((section): section is JsonObject => isObject(section)),
    );

    const presets: string[] = [];

    if ('vue' in deps || '@vitejs/plugin-vue' in deps) {
      presets.push('vue');
    }

    if (
      'react' in deps ||
      '@vitejs/plugin-react' in deps ||
      '@vitejs/plugin-react-swc' in deps
    ) {
      presets.push('react');
    }

    if ('drizzle-orm' in deps || 'drizzle-kit' in deps) {
      presets.push('drizzle');
    }

    if (presets.length > 0) {
      return presets;
    }

    if ('typescript' in deps) {
      return ['base'];
    }
  }

  if (
    existsSync(join(projectDir, 'tsconfig.json')) ||
    existsSync(join(projectDir, 'tsconfig.app.json'))
  ) {
    return ['base'];
  }

  throw new Error(
    'Could not detect project type. Pass presets explicitly: bun generate.ts react drizzle',
  );
}

function normalizePreset(preset: string): string {
  return PRESET_ALIASES[preset] ?? preset;
}

function parseArgs(argv: string[]) {
  const presets: string[] = [];
  let output = DEFAULT_OUTPUT;
  let snippetsDir = DEFAULT_SNIPPETS_DIR;
  let base = DEFAULT_BASE;
  let force = false;
  let useBase = true;
  let list = false;

  for (let index = 0; index < argv.length; index += 1) {
    const arg = argv[index];

    if (arg === '--force') {
      force = true;
      continue;
    }

    if (arg === '--no-base') {
      useBase = false;
      continue;
    }

    if (arg === '--list') {
      list = true;
      continue;
    }

    if (arg === '--output') {
      output = argv[index + 1] ?? output;
      index += 1;
      continue;
    }

    if (arg === '--snippets-dir') {
      snippetsDir = resolve(argv[index + 1] ?? snippetsDir);
      index += 1;
      continue;
    }

    if (arg === '--base') {
      base = argv[index + 1] ?? base;
      index += 1;
      continue;
    }

    if (arg.startsWith('--')) {
      throw new Error(`Unknown flag: ${arg}`);
    }

    presets.push(arg);
  }

  return { presets, output, snippetsDir, base, force, useBase, list };
}

async function listPresets(snippetsDir: string) {
  const glob = new Bun.Glob('*.json');
  const presets: string[] = [];

  for await (const file of glob.scan({ cwd: snippetsDir, absolute: false })) {
    presets.push(file.replace(/\.json$/, ''));
  }

  presets.sort();
  for (const preset of presets) {
    console.log(preset);
  }
}

async function main() {
  const args = parseArgs(process.argv.slice(2));

  if (!existsSync(args.snippetsDir)) {
    throw new Error(`Snippets directory not found: ${args.snippetsDir}`);
  }

  if (args.list) {
    await listPresets(args.snippetsDir);
    return;
  }

  const projectDir = process.cwd();
  const detectedPresets =
    args.presets.length > 0 ? args.presets : await detectPresets(projectDir);
  const presets = detectedPresets.map((preset) => normalizePreset(preset));

  const seen = new Set<string>();
  let merged: JsonObject = {};

  if (args.useBase && !presets.includes(args.base)) {
    const basePath = join(args.snippetsDir, `${args.base}.json`);
    if (existsSync(basePath)) {
      merged = deepMerge(
        merged,
        await resolveConfig(basePath, seen, { includeExtends: true }),
      ) as JsonObject;
    }
  }

  for (const preset of presets) {
    const presetPath = join(args.snippetsDir, `${preset}.json`);

    if (!existsSync(presetPath)) {
      throw new Error(`Unknown preset: ${preset}`);
    }

    merged = deepMerge(
      merged,
      await resolveConfig(presetPath, seen, { includeExtends: false }),
    ) as JsonObject;
  }

  const outputPath = resolve(projectDir, args.output);
  if (existsSync(outputPath) && !args.force) {
    throw new Error(`Output already exists: ${outputPath}. Use --force to overwrite it.`);
  }

  await mkdir(dirname(outputPath), { recursive: true });
  await writeFile(outputPath, `${JSON.stringify(merged, null, 2)}\n`, 'utf8');

  console.log(`Wrote ${outputPath}`);
}

main().catch((error) => {
  console.error(error instanceof Error ? error.message : String(error));
  process.exit(1);
});
