\
#!/bin/bash

# Cache sudo credentials
user=$(sudo whoami)
echo "[+] Running as user: $user"

# Download latest version of firefox
echo "[+] Downloading the latest version of Firefox"
curl -L --progress-bar "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US" -o /tmp/firefox.tar.bz2

echo "[i] Removing existing installation"
sudo rm -rf /opt/Firefox

echo "[+] Extracting application files"
sudo tar xjf /tmp/firefox.tar.bz2 -C /opt/
sudo mv /opt/firefox /opt/Firefox

if [ ! -f /usr/share/applications/firefox.desktop ]; then
	echo "[i] Firefox launcher not found. Adding..."
	sudo cp launchers/firefox.desktop /usr/share/applications
fi

if [ ! -f /usr/share/icons/firefox.png ]; then
    echo "[i] Firefox icon not found. Adding..."
    sudo cp icons/firefox.png /usr/share/icons
fi

# Execute `which` and check if the return code is 0 (successful)
firefox_binary=$(which firefox 2>/dev/null)
if [ $? -ne 0 ]; then
	echo "[i] Firefox binary not found in PATH. Adding..."
	sudo ln -s /opt/Firefox/firefox /usr/local/bin/firefox
fi

echo "[+] Successfully updated to latest version"
