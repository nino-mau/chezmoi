#!/usr/bin/env python3
# Print temp of cpu
import psutil

temps = psutil.sensors_temperatures()
cpu_temp = 0

if "thinkpad" in temps:
    cpu_temp = temps["thinkpad"][0].current or 0
else:
    cpu_temp = temps["amdgpu"][0].current or 0

print(f" {round(cpu_temp):2}°C")
