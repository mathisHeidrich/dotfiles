# dotfiles

## New system

```sh
curl -fsSL https://raw.githubusercontent.com/mathisHeidrich/dotfiles/main/install.sh | bash

# Open a new shell, or run one of these:
# Linux: eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# macOS: eval "$(/opt/homebrew/bin/brew shellenv)"

chezmoi init --apply mathisHeidrich/dotfiles
```

## Update

```sh
chezmoi update
```
