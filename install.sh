#!/bin/bash

sudo cp -r etc /
sudo cp -r home /
sudo chown -R doman:doman ~

sudo pacman -Syu i3-wm i3status xorg-server xorg-xinit dmenu feh maim xorg-xrandr brightnessctl bluez bluez-utils pulsemixer xorg-xinput fish alacritty fastfetch starship btop eclip neovim npm ripgrep composer cmake mingw-w64 valgrind dotnet-runtime dotnet-sdk rustup jdk17-openjdk apache php php-apache mysql phpmyadmin mysql-workbench sdl2_image sdl2_mixer sdl2_ttf sdl2_net mosh openvpn gimp audacity discord atool zip unzip p7zip unrar wine noto-fonts-emoji steam spotify-launcher ntfs-3g

mkdir ~/.aur
cd ~/.aur

git clone https://aur.archlinux.org/i3-layouts.git
cd i3-layouts
makepkg -is
cd ..

git clone https://aur.archlinux.org/picom-ftlabs-git.git
cd picom-ftlabs-git
makepkg -is
cd ..

git clone https://aur.archlinux.org/google-chrome.git
cd google-chrome
makepkg -is
cd ..

git clone https://aur.archlinux.org/minecraft-launcher.git
cd minecraft-launcher
makepkg -is
cd ..

git clone https://aur.archlinux.org/oracle-instantclient-basic.git
cd oracle-instantclient-basic
makepkg -is
cd ..

git clone https://aur.archlinux.org/oracle-instantclient-sqlplus.git
cd oracle-instantclient-sqlplus
makepkg -is
cd ..

git clone https://aur.archlinux.org/onlyoffice-bin.git
cd onlyoffice-bin
makepkg -is
cd ..

git clone https://aur.archlinux.org/packettracer.git

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
