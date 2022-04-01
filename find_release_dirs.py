#!/usr/bin/env python3

import pathlib
import sys


arch = pathlib.Path(sys.argv[2])
released_path = pathlib.Path(sys.argv[1]) / arch
packages = {}

for fn in released_path.glob("**/*"):
    if fn.is_symlink():
        target = fn.resolve()
        if target.parts[:6] == ("/", "reg", "g", "pcds", "pkg_mgr", "release"):
            package, version = target.parts[6:8]
            packages.setdefault(package, set()).add(version)

packages.pop(released_path.parts[6])
for pkg, versions in packages.items():
    for version in sorted(versions):
        print(f"/reg/g/pcds/pkg_mgr/release/{pkg}/{version}")
