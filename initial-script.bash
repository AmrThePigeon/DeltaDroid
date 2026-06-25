#!/bin/bash
set -e

scriptlocation=$(pwd -L)
scriptdeletion() {
rm -f "$scriptlocation/initial-script"
}
trap scriptdeletion EXIT

termux-setup-storage

if [[ -d "$HOME/DeltaDroid" ]]; then
   rm -rf "$HOME/DeltaDroid"
fi

apt update && apt upgrade
pkg install apksigner
pkg install xdelta3
pkg install zipalign
pkg install unzip
pkg install git

curl -s https://raw.githubusercontent.com/AmrThePigeon/DeltaDroid/main/install-apktool.sh | bash
git clone https://github.com/AmrThePigeon/DeltaDroid
chmod +x ./DeltaDroid/DeltaDroid-Installer.bash
./DeltaDroid/DeltaDroid-Installer.bash