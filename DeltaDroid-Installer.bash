#!/bin/bash
termux-setup-storage
apt update && apt upgrade
curl -s https://raw.githubusercontent.com/rendiix/termux-apktool/main/install.sh | bash
pkg install apksigner
pkg install xdelta3
pkg install zipalign
pkg install unzip
read -r -p "Enter DELTARUNE path: " gamepath
gamepath="${gamepath%/}"
echo "Copying Game Files..."
cp -r "$gamepath" "$HOME"
REALgamepath="$HOME/Deltarune"
GameAssets="$HOME/DeltaDroid/DeltaDroid/assets/"
transfolder="$HOME/DeltaDroid/DeltaDroid/assets/trans-folder"
musfiles="$REALgamepath/mus/"
vidfiles="$REALgamepath/chapter3_windows/vid"
oldchapter0file="$REALgamepath/data.win"
oldchapter1file="$REALgamepath/chapter1_windows/data.win"
oldchapter2file="$REALgamepath/chapter2_windows/data.win"
oldchapter3file="$REALgamepath/chapter3_windows/data.win"
oldchapter4file="$REALgamepath/chapter4_windows/data.win"
chapter0xpatch="$transfolder/chapter0.xdelta"
chapter1xpatch="$transfolder/chapter1/chapter1.xdelta"
chapter2xpatch="$transfolder/chapter2/chapter2.xdelta"
chapter3xpatch="$transfolder/chapter3/chapter3.xdelta"
chapter4xpatch="$transfolder/chapter4/chapter4.xdelta"
keystorefile="$HOME/DeltaDroid/SigningKey/UselessSigKey.keystore"
unzip "$GameAssets/game_sfx.zip"
echo "Copying Misc Files..."
cp -r "$musfiles" "$transfolder"
cp -r "$vidfiles" "$transfolder/chapter3"
cp -r "$REALgamepath/chapter1_windows/lang/" "$GameAssets"
mv "$GameAssets/lang/lang_en.json" "$GameAssets/lang/lang_ch1_en.json"
mv "$GameAssets/lang/lang_ja.json" "$GameAssets/lang/lang_ch1_ja.json"
cp -r "$REALgamepath/chapter2_windows/lang/" "$GameAssets"
mv "$GameAssets/lang/lang_ja.json" "$GameAssets/lang/lang_ch2_ja.json"
cp -r "$REALgamepath/chapter3_windows/lang/" "$GameAssets"
mv "$GameAssets/lang/lang_ja.json" "$GameAssets/lang/lang_ch3_ja.json"
cp -r "$REALgamepath/chapter4_windows/lang/" "$GameAssets"
mv "$GameAssets/lang/lang_ja.json" "$GameAssets/lang/lang_ch4_ja.json"
find "$REALgamepath/chapter1_windows/" -name "*.ogg" -exec cp {} "$GameAssets" \;
find "$REALgamepath/chapter2_windows/" -name "*.ogg" -exec cp {} "$GameAssets" \;
cp "$REALgamepath/chapter2_windows/snd_power" "$GameAssets"
find "$REALgamepath/chapter3_windows/" -name "*.ogg" -exec cp {} "$GameAssets" \;
find "$REALgamepath/chapter4_windows/" -name "*.ogg" -exec cp {} "$GameAssets" \;
echo "Patching Chapter Select..."
xdelta3 -d -s "$oldchapter0file" "$chapter0xpatch" "$transfolder/game.droid"
cp "$transfolder/game.droid" "$transfolder/chapter0/"
echo "Patching Chapter 1"
xdelta3 -d -s "$oldchapter1file" "$chapter1xpatch" "$transfolder/chapter1/game.droid"
echo "Patching Chapter 2"
xdelta3 -d -s "$oldchapter2file" "$chapter2xpatch" "$transfolder/chapter2/game.droid"
echo "Patching Chapter 3"
xdelta3 -d -s "$oldchapter3file" "$chapter3xpatch" "$transfolder/chapter3/game.droid"
echo "Patching Chapter 4"
xdelta3 -d -s "$oldchapter4file" "$chapter4xpatch" "$transfolder/chapter4/game.droid"
rm "$chapter0xpatch"
rm "$chapter1xpatch"
rm "$chapter2xpatch"
rm "$chapter3xpatch"
rm "$chapter4xpatch"
rm -rf "$REALgamepath"
echo "Patching Complete! Time for Building!"
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
sleep 5
echo "Building Complete and the apk file is saved at Downloads folder"
