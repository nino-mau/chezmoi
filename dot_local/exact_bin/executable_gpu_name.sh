#!/bin/bash
fastfetch --format json | jq -r '.[] | select(.type=="GPU") | .result[0].name'
