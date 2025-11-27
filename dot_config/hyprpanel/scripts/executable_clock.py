#!/usr/bin/env python3
from datetime import datetime
import json
import locale

# Set locale to French
locale.setlocale(locale.LC_TIME, "fr_FR.UTF-8")


def capitalize_date(date_string):
    """Capitalize first letter of each word in the date string"""
    return " ".join(word.capitalize() for word in date_string.split())


formatted = capitalize_date(datetime.now().strftime("%A, %b %d  •  %H:%M"))

data = {
    "label": formatted,
    "tooltip": capitalize_date(datetime.now().strftime("%A, %B %d, %Y • %H:%M:%S")),
}

print(json.dumps(data))
