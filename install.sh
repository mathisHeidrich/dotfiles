#!/bin/bash
set -euo pipefail

if [[ "$(uname)" == "Linux" ]]; then
    echo "Installing Homebrew prerequisites..."
    sudo apt-get update
    sudo apt-get install -y build-essential procps curl file git
fi

if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ "$(uname)" == "Linux" ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    elif [[ "$(uname)" == "Darwin" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "Homebrew is already installed."
fi

if ! command -v chezmoi &> /dev/null; then
    echo "Installing chezmoi..."
    brew install chezmoi
else
    echo "chezmoi is already installed."
fi

echo "Homebrew and chezmoi are installed."
echo "Run: chezmoi init --apply mathisHeidrich/dotfiles"
