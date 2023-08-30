USER=solar
USERDATA=/mnt/c/Users/$USER
APPDATA=$USERDATA/AppData/Roaming

echo 'copying alacrity config...'
cp -r ./alacritty $APPDATA

echo 'copying git config...'
cp ./git/.gitconfig $USERDATA

echo 'copying bash config...'
cp ./bash/.bash_profile $USERDATA

echo 'copying Windows cli-only programs'
cp -r ./commands $USERDATA
