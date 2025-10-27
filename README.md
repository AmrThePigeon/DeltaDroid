# DeltaDroid

A mod for DELTARUNE to make it playable on mobile

# Installation
**Prerequisites**

1- Arm64 android phone

2- Termux (Terminal Emulator for android)

3- 4-5 GB free storage

**Installation**:
- Execute this one line command
```
apt update && apt upgrade && pkg install git && curl -s https://raw.githubusercontent.com/AmrThePigeon/DeltaDroid/main/install-apktool.sh | bash && git clone https://github.com/AmrThePigeon/DeltaDroid && chmod +x ./DeltaDroid/DeltaDroid-Installer.bash && ./DeltaDroid/DeltaDroid-Installer.bash
```

**This script will basically do the following:**

Installs Apktool (Ported to Termux by [rendix](https://github.com/rendiix))
And apksigner, zipalign, xdelta3 and unzip

Copies Deltarune files to the cloned repository directory

Patches the data.win files with the mod using xdelta3

Rebuilds the app using Apktool

Using Zipalign for the apk

It signs the apk file with the test signature from the repository

And finally, it copies the final apk file to `/storage/emulated/0/Download`


// This project isn't affiliated with toby fox, Please buy the game before using. and use at your own responsibility

This project was made for fun so let me know if you enjoy it
And also please join my discord server 
https://discord.gg/vY8CsZHkjR

This page isn't well updated yet (It will include the credits, Manual Installation instead of one line command, etc) I will update it as soon as I can so please be patient

Thanks✌️
