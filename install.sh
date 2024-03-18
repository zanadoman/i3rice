#!/bin/bash

sudo cp -r etc /
sudo cp -r home/doman/* ~/
sudo chown -R $USER:$USER ~

sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo pacman -Syu
sudo pacman -S i3-wm i3status xorg-server xorg-xinit dmenu picom feh maim xorg-xrandr bluez bluez-utils pulsemixer xorg-xinput fish rxvt-unicode fastfetch starship micro htop xclip code cmake mingw-w64 valgrind dotnet-runtime dotnet-sdk jdk-openjdk php mysql-workbench sdl2_image sdl2_mixer sdl2_ttf sdl2_net mosh nemo nemo-fileroller libreoffice-fresh gimp inkscape audacity discord wine noto-fonts-emoji steam jdk17-openjdk spotify-launcher

chsh -s /bin/fish
echo "set -U fish_greeting" | fish

mkdir ~/.aur
cd ~/.aur

git clone https://aur.archlinux.org/i3-layouts.git
cd i3-layouts
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

git clone https://aur.archlinux.org/packettracer.git