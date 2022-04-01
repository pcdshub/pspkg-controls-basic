#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR || exit 1

VERSION=${VERSION-0.0.1}
PACKAGE_NAME="controls-basic"
SOURCE=/reg/g/pcds/pkg_mgr/release/${PACKAGE_NAME}-${VERSION}
ARCH=x86_64-rhel7-gcc48-opt
ARCH_ALIAS=rhel7-x86_64
ARCHIVE_NAME=${PACKAGE_NAME}-${VERSION}

set -e

release_dirs=$(python find_release_dirs.py $SOURCE $ARCH)
python find_files_to_copy.py "${ARCH}" ${release_dirs} > to_copy.txt
find "$SOURCE/$ARCH" >> to_copy.txt

# tar czf  --files-from=to_copy.txt | tar xv -C $SCRIPT_DIR/released_env/
mkdir -p ./released_env

# tar cvf - --files-from=to_copy.txt | tar xv -C "${SCRIPT_DIR}/released_env/"
pushd "$SCRIPT_DIR/released_env/reg/g/pcds/pkg_mgr/release/${PACKAGE_NAME}-${VERSION}" || exit 1
ln -sf "$ARCH" "$ARCH_ALIAS"
popd

tar czf "${SCRIPT_DIR}/${PACKAGE_NAME}-${VERSION}.tgz" -C "${SCRIPT_DIR}/released_env/" .
