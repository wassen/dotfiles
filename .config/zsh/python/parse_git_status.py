#!/usr/bin/env python3

import sys
import shlex

filenames = []

for line in sys.stdin:
    line = line.strip()
    
    if line:
        parts = shlex.split(line)
        
        _status = parts[0]
        filename = parts[-1]

        filenames.append(filename)

print(" ".join(filenames))
