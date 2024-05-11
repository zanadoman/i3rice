#!/bin/bash

sudo cp -r etc /
sudo cp -r home /
sudo chown -R doman:doman ~

sudo pacman -Syu i3-wm i3status xorg-server xorg-xinit dmenu feh maim xorg-xrandr brightnessctl bluez bluez-utils pulsemixer xorg-xinput fish alacritty fastfetch starship btop eclip neovim npm ripgrep composer clang cmake mingw-w64 valgrind dotnet-runtime dotnet-sdk rustup jdk17-openjdk apache php php-apache mysql phpmyadmin mysql-workbench sdl2 sdl2_image sdl2_mixer sdl2_ttf mosh openvpn gimp audacity discord atool zip unzip p7zip unrar wine noto-fonts-emoji steam spotify-launcher ntfs-3g

yay -S autotiling picom-ftlabs-git google-chrome minecraft-launcher oracle-instatnclient-sqlplus onlyoffice-bin mingw-w64-cmake mingw-w64-sdl2 mingw-w64-sdl2_image mingw-w64-sdl2_mixer mingw-w64-sdl2_ttf 

pacman -Qdtq | sudo pacman -Rns -

sudo grub-mkconfig -o /boot/grub/grub.cfg

chsh -s /bin/fish
echo "set -U fish_greeting" | fish

sudo chmod 557 /srv/http
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl start mariadb.service
sudo mariadb -u root -p
sudo mariadb-secure-installation
rustup default stable

mkdir ~/Downloads
mkdir ~/Documents
mkdir ~/Projects
mkdir ~/Pictures
mkdir ~/Videos
mkdir ~/.path
