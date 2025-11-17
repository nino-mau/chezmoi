#!/usr/bin/env python3
from datetime import datetime
import json

formatted = datetime.now().strftime("%A, %b %d  •  %H:%M")

data = {
    "label": formatted,
    "tooltip": datetime.now().strftime("%A, %B %d, %Y • %H:%M:%S"),
}

print(json.dumps(data))
