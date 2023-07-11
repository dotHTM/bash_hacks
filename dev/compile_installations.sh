#!/usr/bin/env bash
# compile_installations.sh


if [[ -z "$BH_PRIVATE_BASHRC_PATH" ]]; then
    echo "The env variable BH_PRIVATE_BASHRC_PATH is empty. Please set an export for your shell or environment."
    exit
fi

savedParent="${BH_PRIVATE_BASHRC_PATH}/installations"


mkdir -p "$savedParent"




PYTHON_INSTALLATIONS="${savedParent}/python.txt"
RUBY_INSTALLATIONS="${savedParent}/ruby.txt"
HOMEBREW_INSTALLATIONS="${savedParent}/homebrew.txt"
HOMEBREW_FORMULA="${savedParent}/homebrew_formula.txt"
HOMEBREW_CASK="${savedParent}/homebrew_cask.txt"



# Ruby Installations
    gem list > "$RUBY_INSTALLATIONS"

# Python Installations
    pip3 list > "$PYTHON_INSTALLATIONS"

# Homebrew Installations
    touch "$HOMEBREW_INSTALLATIONS"
    brew list --formula > "$HOMEBREW_FORMULA"
    brew list --cask > "$HOMEBREW_CASK"
