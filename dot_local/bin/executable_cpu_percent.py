#!/usr/bin/env python3
# Display cpu percentage of usage
import psutil

cpu_percent = psutil.cpu_percent(interval=1)
print(f" {cpu_percent}%")
