#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import psutil

# Obter dados do sistema
cpu_percent = psutil.cpu_percent(interval=1)
temps = psutil.sensors_temperatures()
cpu_temp = temps["thinkpad"][0].current or 0
mem = psutil.virtual_memory()
gpu_name = "Radeon RX 9070 XT"

if "thinkpad" in temps:
    cpu_temp = temps["thinkpad"][0].current or 0
    gpu_name = "NVIDIA GeForce MX250"

print(f"󰢮 {gpu_name}   {mem.percent}%  󱓞 {round(cpu_percent):2}%   {round(cpu_temp):2}°C")
