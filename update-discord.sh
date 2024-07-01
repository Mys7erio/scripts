#!/bin/bash

# Cache sudo credentials
user=$(sudo whoami)
echo "[+] Running as user: $user"

# Download latest version of discord
echo "[+] Downloading the latest version of Discord"
curl -L --progress-bar "https://discord.com/api/download?platform=linux&format=tar.gz" -o /tmp/discord.tar.gz

echo "[i] Removing existing installation"
sudo rm -rf /opt/Discord

echo "[+] Extracting application files"
sudo tar xzf /tmp/discord.tar.gz -C /opt

echo "[+] Successfully updated to latest version"
