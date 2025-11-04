#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import psutil

# Obter dados do sistema
cpu_percent = psutil.cpu_percent(interval=1)
temps = psutil.sensors_temperatures()
cpu_temp = temps["thinkpad"][0].current or 0

print(f" AMD Ryzen 7 󱓞 {round(cpu_percent):2}%  {round(cpu_temp):2}°C ")
