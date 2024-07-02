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

if [ ! -f /usr/share/applications/discord.desktop ]; then
	echo "[i] Discord launcher not found. Adding..."
	sudo cp launchers/discord.desktop /usr/share/applications
fi

if [ ! -f /usr/share/icons/discord.png ]; then
    echo "[i] Discord icon not found. Adding..."
    sudo cp icons/firefox.png /usr/share/icons
fi

# Execute which and check the return code is 0 (successful)
discord_binary=$(which discord 2>/dev/null)
if [ $? -ne 0 ]; then
	echo "[i] Discord binary not found in PATH. Adding..."
	sudo ln -s /opt/Discord/Discord /usr/local/bin/discord
fi


echo "[+] Successfully updated to latest version"
