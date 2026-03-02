#!/bin/bash

# --- 1. Variablen setzen ---
# Wir nutzen den Standardnamen, damit SSH ihn automatisch findet
KEY_PATH="$HOME/.ssh/id_ed25519"
# Kommentar für GitHub (Hostname hilft bei der Unterscheidung in der Web-UI)
COMMENT="mathis.heidrich@$(hostname)"

echo "--- SSH Key Generator (Standard-Mode) ---"

# Prüfen, ob der Key schon existiert
if [ -f "$KEY_PATH" ]; then
    echo "⚠️  Hinweis: Ein Standard-Key existiert bereits unter $KEY_PATH"
    read -p "Soll der vorhandene Key überschrieben werden? (y/n): " CONFIRM
    if [[ $CONFIRM != "y" ]]; then
        echo "Abgebrochen."
        exit 0
    fi
fi

# Verzeichnis sicherstellen
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# --- 2. Key generieren ---
echo "Generiere Key für: $COMMENT"
ssh-keygen -t ed25519 -C "$COMMENT" -f "$KEY_PATH"

# --- 3. SSH-Agent starten & Key hinzufügen ---
echo "Aktiviere SSH-Agent..."
eval "$(ssh-agent -s)"
ssh-add "$KEY_PATH"

# --- 4. Public Key für GitHub anzeigen ---
echo ""
echo "-------------------------------------------------------"
echo "✅ FERTIG! Kopiere diesen Public Key für GitHub:"
echo "-------------------------------------------------------"
cat "${KEY_PATH}.pub"
echo "-------------------------------------------------------"
echo "Link: https://github.com/settings/keys"
echo "-------------------------------------------------------"

# Verbindungstest Erinnerung
echo "Tipp: Sobald eingefügt, teste mit: ssh -T git@github.com"
