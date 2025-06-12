#!/usr/bin/env bash
# do_updates.sh


set -e 

ms_au_app="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app"
if [[ -e "$ms_au_app" ]]; then
    echo "==== MS Office ================================"
    osascript -e 'tell app "Microsoft Edge" to quit'
    osascript -e 'tell app "Microsoft Excel" to quit'
    osascript -e 'tell app "Microsoft OneNote" to quit'
    osascript -e 'tell app "Microsoft Outlook" to quit'
    osascript -e 'tell app "Microsoft PowerPoint" to quit'
    osascript -e 'tell app "Microsoft Teams" to quit'
    osascript -e 'tell app "Microsoft Word" to quit'
    open "$ms_au_app"
    echo
fi

if [[ "Darwin" == $(uname) ]]; then
    echo "==== macOS ================================"
    softwareupdate --install --recommended
    echo
fi

if [[ -n $(which brew) ]]; then
    echo "==== Homebrew ================================"
    brew update
    brew upgrade
    brew upgrade --cask --greedy
    brew cleanup
    echo
fi

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
pipx upgrade (pipx list --json | jq -r ".venvs | keys[]")
echo
fi

if [[ -n $(which gem) ]]; then
echo "==== Ruby/gem ================================"
gem update --system
gem update
gem cleanup
echo
fi
