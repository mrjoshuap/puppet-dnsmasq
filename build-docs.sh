#!/bin/bash

[ -d "${PWD:-.}/docs" ] && rm "${PWD:-.}/docs/*" 2> /dev/null || mkdir -p "${PWD:-.}/docs"

for i in manifests/*.pp;
do
  MANIFEST="${i##*/}"
  MANIFEST="${MANIFEST%.*}"
  echo "Generating docs for ${i}"
  puppet doc "${i}" > "${PWD:-.}/docs/${MANIFEST}.md"
  unset MANIFEST
done
