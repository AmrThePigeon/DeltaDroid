#!/bin/bash
set -e
if termux-setup-storage; then
   echo -e "\e[32mAccept the permissions\e[0m"
else
   echo -e "\e[32mPermissions already accepted\e[0m"
fi

if [[ -d "$HOME/DeltaDroid" ]]; then
   rm -rf "$HOME/DeltaDroid"
fi

apt update && apt upgrade
pkg install apksigner
pkg install xdelta3
pkg install aapt
pkg install unzip
pkg install git

curl -s https://raw.githubusercontent.com/AmrThePigeon/DeltaDroid/main/install-apktool.sh | bash
git clone https://github.com/AmrThePigeon/DeltaDroid
chmod +x ./DeltaDroid/DeltaDroid-Installer.bash
./DeltaDroid/DeltaDroid-Installer.bash
