#!/usr/bin/env bash
# update_pip.sh

set -e

echo "==== Python/pip ================================"
pips=""
for v in $(seq 11); do
    pips+="pip3.$v "
done


echo "### Pips:"
for this_pip in $pips; do
    if [[ -n $(which $this_pip) ]]; then
        echo "- $this_pip"
    fi
done
for this_pip in $pips; do
    if [[ -n $(which $this_pip) ]]; then
        echo "==== $this_pip ===="
        $this_pip list --outdated
        $this_pip install --upgrade pip
        $this_pip list --outdated --format=json \
            | jq -r '.[].name' \
            | xargs -n1 $this_pip install -U
    fi
done
echo
if [[ -n $(which pipx) ]]; then
echo "==== pipx ================================"
pipx upgrade-all
echo
fi
