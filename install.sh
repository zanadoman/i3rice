#!/bin/bash

sudo pacman -Syu i3-wm i3status xorg-server xorg-xinit dmenu picom feh maim xorg-xrandr brightnessctl bluez bluez-utils pulsemixer xorg-xinput fish alacritty fastfetch starship btop xclip neovim npm cmake mingw-w64 valgrind dotnet-runtime dotnet-sdk jdk-openjdk php mysql-workbench sdl2_image sdl2_mixer sdl2_ttf sdl2_net mosh openvpn gameconqueror ranger w3m libreoffice-fresh gimp inkscape audacity discord wine noto-fonts-emoji steam jdk17-openjdk spotify-launcher ntfs-3g

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

git clone https://aur.archlinux.org/packettracer.git

pacman -Qdtq | sudo pacman -Rns -

sudo cp -r etc /
sudo cp -r home /
sudo chown -R doman:doman ~

chsh -s /bin/fish
echo "set -U fish_greeting" | fish

sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo chmod 777 /srv/http

mkdir ~/Desktop
mkdir ~/Downloads
mkdir ~/Documents
mkdir ~/Pictures
mkdir ~/Videos
mkdir ~/Music
mkdir ~/.path
