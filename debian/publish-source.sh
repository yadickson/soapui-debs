#!/bin/bash

set -ex

PKG="${PACKAGE_NAME:-${1}}"
VERSION="${PACKAGE_VERSION:-${2}}"
ORIG_TARBALL="../${PKG}_${VERSION}.orig.tar.gz"

[ -f "${ORIG_TARBALL}" ] || exit 1

rm -rf .pc target build
rm -rf pom.xml* soapui*
rm -f README RELEASENOTES.txt

tar --strip-components=1 -xzf "${ORIG_TARBALL}" "${PKG}-${VERSION}" || exit 1

