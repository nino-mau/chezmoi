#!/usr/bin/env python3
# Print temp of cpu
import platform
import subprocess

cpu_temp = 0

if platform.system() == "Darwin":
    # macOS: use powermetrics (requires sudo) or osx-cpu-temp if available
    try:
        # Try osx-cpu-temp first (brew install osx-cpu-temp)
        result = subprocess.run(
            ["osx-cpu-temp"], capture_output=True, text=True, timeout=5
        )
        if result.returncode == 0:
            # Output is like "78.2°C"
            cpu_temp = float(result.stdout.strip().replace("°C", ""))
    except FileNotFoundError:
        # Fallback: try using sudo powermetrics (may not work without sudo)
        try:
            result = subprocess.run(
                [
                    "sudo",
                    "-n",
                    "powermetrics",
                    "-n",
                    "1",
                    "-i",
                    "1",
                    "--samplers",
                    "smc",
                ],
                capture_output=True,
                text=True,
                timeout=5,
            )
            for line in result.stdout.splitlines():
                if "CPU die temperature" in line:
                    cpu_temp = float(line.split(":")[1].strip().replace(" C", ""))
                    break
        except (FileNotFoundError, subprocess.TimeoutExpired):
            pass
    except subprocess.TimeoutExpired:
        pass
else:
    # Linux: use psutil
    import psutil

    temps = psutil.sensors_temperatures()

    if "thinkpad" in temps:
        cpu_temp = temps["thinkpad"][0].current or 0
    else:
        cpu_temp = temps["amdgpu"][0].current or 0

print(f" {round(cpu_temp):2}°C")
