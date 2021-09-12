#!/usr/bin/env bash
# mkmv.sh

file=$1 && shift


mkdir -p "tmp/${file}"
mv "$file" "tmp/${file}"
mv "tmp/${file}" "$file"

