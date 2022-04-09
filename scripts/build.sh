#!/bin/bash
set -e

if [[ -z "${VERSION_TAG}" ]]; then
    echo "Parameter VERSION_TAG missing!"
fi

if [[ -z "${DEB_FLAVOR}" ]]; then
    echo "Parameter DEB_FLAVOR missing!"
fi

SCRIPT=$(readlink -f "$0")
SCRIPTDIR=$(dirname "${SCRIPT}")
WORKDIR="${PWD}"

git config --global advice.detachedHead false

# Display tools version
cmake --version | head -n 1

# Enable ccache
export PATH="/usr/lib/ccache:${PATH}"
export CCACHE_DIR="${WORKDIR}/cache/ccache"

# Checkout handbreak
cd "${WORKDIR}"
if [[ -d bareos ]]; then
  cd bareos
  git clean -xdf
  git fetch -t
  git checkout master
  git pull --ff-only
  cd ..
else
  git clone --branch master https://github.com/bareos/bareos
fi

cd bareos
echo "Checkout from tag: ${VERSION_TAG}"
git checkout "Release/${VERSION_TAG}"
COMMIT_HASH=$(git log -n 1 --pretty=format:'%h' --abbrev=8)

# create original source tar file - just for dpkg-buildpackage compatibility
git archive master | bzip2 > ../bareos_${VERSION_TAG}.orig.tar.bz2
(
  echo "bareos (${VERSION_TAG}-${COMMIT_HASH}) unstable; urgency=high"
  echo ""
  echo "  * upstream release"
  echo ""
  echo " -- Stefan Meinecke <meinecke@greensec.de>  $(date '+%a, %d %b %Y %H:%M:%S %z')"
  echo ""
) > debian/changelog

DEB_BUILD_OPTIONS="nocheck nodocs" dpkg-buildpackage -j$(nproc) -d -us -b
cd ..
rm -vf *-dbg*.deb

for x in bareos-*; do
    mv -v $x bareos-${DEB_FLAVOR}-${x:7}
done
