# DeltaDroid

**The port was updated to chapter 5 recently. Check it out!**

A mod for DELTARUNE to make it playable on mobile

# Installation
**Prerequisites**

1- Arm64 android phone

2- Termux (Terminal Emulator for android)

3- 5 GB free storage

4- Deltarune files copied from PC

**Installation**:
- Execute this one line command
```
rm -f initial-script.bash >/dev/null 2>&1 && curl -L -O https://raw.githubusercontent.com/AmrThePigeon/DeltaDroid/refs/heads/main/initial-script.bash && chmod +x initial-script.bash && ./initial-script.bash
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
And also please join my discord server and let me know if you got ANY idea of any bug fixing, Changes or feature adding to this port
https://discord.gg/sdnA69J5Bq

This page isn't well updated yet (It will include the credits, Manual Installation instead of one line command, etc) I will update it as soon as I can so please be patient

Thanks✌️
