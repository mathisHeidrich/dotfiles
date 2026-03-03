#!/bin/bash

KEY_PATH="$HOME/.ssh/id_ed25519"
COMMENT="mathis.heidrich@$(hostname)"

echo "SSH Key Generator"

if [ -f "$KEY_PATH" ]; then
    echo "Warning: a key already exists at $KEY_PATH"
    read -r -p "Overwrite the existing key? (y/n): " CONFIRM
    if [[ $CONFIRM != "y" ]]; then
        echo "Aborted."
        exit 0
    fi
fi

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

echo "Generating key for: $COMMENT"
ssh-keygen -t ed25519 -C "$COMMENT" -f "$KEY_PATH"

echo "Starting ssh-agent..."
eval "$(ssh-agent -s)"
ssh-add "$KEY_PATH"

echo ""
echo "-------------------------------------------------------"
echo "Done. Copy this public key to GitHub:"
echo "-------------------------------------------------------"
cat "${KEY_PATH}.pub"
echo "-------------------------------------------------------"
echo "GitHub: https://github.com/settings/keys"
echo "-------------------------------------------------------"
echo "Tip: after adding it, test with: ssh -T git@github.com"
