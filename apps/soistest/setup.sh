#!/bin/bash

cd eds || exit 1
rm -f ./*.xml

find ../ccsds.sois/seds/interoperability/common/${1}/ -type f -name '*.xml' | while read -r i
do
    j=$(basename "$i")
    ln -sv "$i" "$j"
done
