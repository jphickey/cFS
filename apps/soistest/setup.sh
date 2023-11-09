#!/bin/bash

if [ ! -d ccsds.sois ]; then
    exit 1
fi

mkdir -f eds
cd eds || exit 1

# leave the cleanup to manual step for now
# rm -f ./*.xml

find ../ccsds.sois/seds/interoperability/common/${1}/ -type f -name '*.xml' | while read -r i
do
    j=$(basename "$i")
    ln -sv "$i" "$j"
done
