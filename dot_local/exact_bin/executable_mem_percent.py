#!/usr/bin/env python3
# Display memory percent
import psutil

mem = psutil.virtual_memory()
print(mem.percent)
