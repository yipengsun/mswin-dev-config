USER=solar
APPDATA=/mnt/c/Users/$USER/AppData/Roaming

echo 'copying alacrity config...'
cp -r ./alacritty $APPDATA

echo 'copying git config...'
cp ./git/.gitconfig /mnt/c/Users/$USER
