#!/bin/bash
set -e
read -r -p "Enter DELTARUNE path: " gamepath
gamepath="${gamepath%/}"
if [[ ! -f "$gamepath/data.win" && ! -f "$gamepath/chapter1_windows/data.win" && ! -f "$gamepath/chapter2_windows/data.win" && ! -f "$gamepath/chapter3_windows/data.win" && ! -f "$gamepath/chapter4_windows/data.win" && ! -f "$gamepath/chapter5_windows/data.win"]]; then
   echo -e "\033[31mError: game files not found\033[0m"
fi

echo "Copying Game Files..."
cp -r "$gamepath" "$HOME"
REALgamepath="$HOME/DELTARUNE"
GameAssets="$HOME/DeltaDroid/DeltaDroid/assets/"
transfolder="$HOME/DeltaDroid/DeltaDroid/assets/trans-folder"
musfiles="$REALgamepath/mus/"
ch3vidfiles="$REALgamepath/chapter3_windows/vid"
ch5vidfiles="$REALgamepath/chapter5_windows/vid"
oldchapter0file="$REALgamepath/data.win"
oldchapter1file="$REALgamepath/chapter1_windows/data.win"
oldchapter2file="$REALgamepath/chapter2_windows/data.win"
oldchapter3file="$REALgamepath/chapter3_windows/data.win"
oldchapter4file="$REALgamepath/chapter4_windows/data.win"
oldchapter4file="$REALgamepath/chapter5_windows/data.win"
chapter0xpatch="$transfolder/chapter0.xdelta"
chapter1xpatch="$transfolder/chapter1/chapter1.xdelta"
chapter2xpatch="$transfolder/chapter2/chapter2.xdelta"
chapter3xpatch="$transfolder/chapter3/chapter3.xdelta"
chapter4xpatch="$transfolder/chapter4/chapter4.xdelta"
chapter5xpatch="$transfolder/chapter5/chapter5.xdelta"
keystorefile="$HOME/DeltaDroid/SigningKey/UselessSigKey.keystore"

mkdir "$transfolder/chapter0"
unzip -o -q "$GameAssets/game_sfx.zip" -d "$GameAssets"
rm "$GameAssets/game_sfx.zip"
echo "Copying Misc Files..."
cp -r "$musfiles" "$transfolder"
cp -r "$ch3vidfiles" "$transfolder/chapter3"
cp -r "$ch5vidfiles" "$transfolder/chapter5"
cp -r "$REALgamepath/chapter1_windows/lang/" "$GameAssets"
mv "$GameAssets/lang/lang_en.json" "$GameAssets/lang/lang_ch1_en.json"
mv "$GameAssets/lang/lang_ja.json" "$GameAssets/lang/lang_ch1_ja.json"
cp -r "$REALgamepath/chapter2_windows/lang/" "$GameAssets"
mv "$GameAssets/lang/lang_ja.json" "$GameAssets/lang/lang_ch2_ja.json"
cp -r "$REALgamepath/chapter3_windows/lang/" "$GameAssets"
mv "$GameAssets/lang/lang_ja.json" "$GameAssets/lang/lang_ch3_ja.json"
cp -r "$REALgamepath/chapter4_windows/lang/" "$GameAssets"
mv "$GameAssets/lang/lang_ja.json" "$GameAssets/lang/lang_ch4_ja.json"
cp -r "$REALgamepath/chapter5_windows/lang/" "$GameAssets"
mv "$GameAssets/lang/lang_ja.json" "$GameAssets/lang/lang_ch5_ja.json"
find "$REALgamepath/chapter1_windows/" -name "*.ogg" -exec cp {} "$GameAssets" \;
find "$REALgamepath/chapter2_windows/" -name "*.ogg" -exec cp {} "$GameAssets" \;
cp "$REALgamepath/chapter2_windows/snd_power" "$GameAssets"
find "$REALgamepath/chapter3_windows/" -name "*.ogg" -exec cp {} "$GameAssets" \;
find "$REALgamepath/chapter4_windows/" -name "*.ogg" -exec cp {} "$GameAssets" \;
find "$REALgamepath/chapter5_windows/" -name "*.ogg" -exec cp {} "$GameAssets" \;
find "$REALgamepath/chapter5_windows/" -name "*.dll" -exec cp {} "$GameAssets" \;

echo "Patching Chapter Select..."

if xdelta3 -d -s "$oldchapter0file" "$chapter0xpatch" "$transfolder/game.droid"; then
   cp "$transfolder/game.droid" "$transfolder/chapter0/"
   echo "Patching Chapter 1"
else
   echo -e "\033[31mError: chapter select file was not patched correctly.\033[0m"
   exit 0
   rm -rf "$HOME/DeltaDroid"
fi

if xdelta3 -d -s "$oldchapter1file" "$chapter1xpatch" "$transfolder/chapter1/game.droid"; then
   echo "Patching Chapter 2"
else
   echo -e "\033[31mError: chapter 1 file was not patched correctly.\033[0m"
   exit 0
   rm -rf "$HOME/DeltaDroid"
fi

if xdelta3 -d -s "$oldchapter2file" "$chapter2xpatch" "$transfolder/chapter2/game.droid"; then
   echo "Patching Chapter 3"
else
   echo -e "\033[31mError: chapter 2 file was not patched correctly.\033[0m"
   exit 0
   rm -rf "$HOME/DeltaDroid"
fi

if xdelta3 -d -s "$oldchapter3file" "$chapter3xpatch" "$transfolder/chapter3/game.droid"; then
   echo "Patching Chapter 4"
else
   echo -e "\033[31mError: chapter 3 file was not patched correctly.\033[0m"
   exit 0
   rm -rf "$HOME/DeltaDroid"
fi

if xdelta3 -d -s "$oldchapter4file" "$chapter4xpatch" "$transfolder/chapter4/game.droid"; then
   echo "Patching Chapter 5"
else
   echo -e "\033[31mError: chapter 4 file was not patched correctly.\033[0m"
   exit 0
   rm -rf "$HOME/DeltaDroid"
fi

if xdelta3 -d -s "$oldchapter5file" "$chapter5xpatch" "$transfolder/chapter5/game.droid"; then
   echo -e "\e[32mPatching Successful... building apk file\e[0m"
else
   echo -e "\033[31mError: chapter 5 file was not patched correctly.\033[0m"
   exit 0
   rm -rf "$HOME/DeltaDroid"
fi

rm "$chapter0xpatch"
rm "$chapter1xpatch"
rm "$chapter2xpatch"
rm "$chapter3xpatch"
rm "$chapter4xpatch"
rm "$chapter5xpatch"
rm -rf "$REALgamepath"

apktool b "$HOME/DeltaDroid/DeltaDroid" -o "$HOME/DeltaDroid1.apk" --use-aapt2
zipalign -v 4 "$HOME/DeltaDroid1.apk" "$HOME/DeltaDroid2.apk"
rm "$HOME/DeltaDroid1.apk"
apksigner sign \
  --ks "$keystorefile" \
  --ks-key-alias UselessSigKey \
  --ks-pass pass:UselessSigKey \
  --key-pass pass:UselessSigKey \
  --out DeltaDroidsigned.apk \
  DeltaDroid2.apk
sleep 2

rm DeltaDroid2.apk
mv DeltaDroidsigned.apk DeltaDroid.apk
mv DeltaDroid.apk "/storage/emulated/0/Download"

if [[ -f "/storage/emulated/0/Download/DeltaDroid.apk" ]]; then
   rm -rf "$HOME/DeltaDroid"
   sleep 5
   echo -e "\e[32mBuilding Complete and the apk file is saved at Downloads folder\e[0m"
else
   echo -e "\033[31mThe apk file doesn't exist in the downloads folder... try the script again and make sure termux has proper storage permissions\033[0m"
   exit 0
fi