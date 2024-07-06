\
#!/bin/bash

# Cache sudo credentials
user=$(sudo whoami)
echo "[+] Running as user: $user"

# Download latest version of VS Code
echo "[+] Downloading the latest version of VS Code"
curl -L --progress-bar "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64" -o /tmp/vscode.tar.gz

# Not removing old vscode dir because there might be some config files
# echo "[i] Removing existing installation"
# sudo rm -rf /opt/VSCode-linux-x64

echo "[+] Extracting application files"
sudo tar xvf /tmp/vscode.tar.gz -C /opt/

if [ ! -f /usr/share/applications/vscode.desktop ]; then
	echo "[i] VSCode launcher not found. Adding..."
	sudo cp launchers/vscode.desktop /usr/share/applications
fi

if [ ! -f /usr/share/icons/vscode.png ]; then
    echo "[i] VSCode icon not found. Adding..."
    sudo cp icons/vscode.png /usr/share/icons
fi

# Execute `which` and check if the return code is 0 (successful)
vscode_binary=$(which code 2>/dev/null)
if [ $? -ne 0 ]; then
	echo "[i] VSCode binary not found in PATH. Adding..."
	sudo ln -s /opt/VSCode-linux-x64/code /usr/local/bin/code
fi

echo "[+] Successfully updated to latest version"
