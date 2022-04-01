#!/usr/bin/env python3

import sys
import pathlib

arch, paths = sys.argv[1], sys.argv[2:]

for path in paths:
    arch_path = pathlib.Path(path) / arch
    for file in arch_path.glob("**/*"):
        parts = file.parts[len(arch_path.parts):]
        if parts[0] == "build":
            continue
        print(file)
