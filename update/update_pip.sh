#!/usr/bin/env bash
# update_pip.sh

set -e

echo "==== Python/pip ================================"
pips="pip3.7 pip3.8 pip3.9 pip3.10 pip3.11"
echo "### Pips:"
for this_pip in $pips; do
    if [[ -n $(which $this_pip) ]]; then
        echo "- $this_pip"
    fi
done
for this_pip in $pips; do
    if [[ -n $(which $this_pip) ]]; then
        echo "==== $this_pip ===="
        # $this_pip list
        $this_pip install --upgrade pip
        $this_pip freeze --local \
            | grep -v '^\-e' \
            | cut -d = -f 1  \
            | xargs -n1 $this_pip install -U
    fi
done
echo
if [[ -n $(which pipx) ]]; then
echo "==== pipx ================================"
pipx upgrade $( pipx list --json | jq -r ".venvs | keys[]" )
echo
fi