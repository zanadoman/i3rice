#!/bin/bash

# System
sudo cp -a ./etc/. /etc/
sudo chown -R root:root /etc/
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Packages
cat ./pacman.txt | sudo pacman -S -
cat ./aur.txt | yay -S -
pacman -Qdtq | sudo pacman -Rns -

# User
cp -a ./home/. "$HOME/"
chsh -s /bin/fish

# MariaDB
sudo mariadb-install-db --user=mysql --basedir=/usr/ --datadir=/var/lib/mysql/
sudo systemctl start mariadb.service
sudo mariadb-secure-installation
sudo systemctl enable mariadb.service

# Rust
rustup default stable

# Folders
mkdir -p "$HOME/.local/bin/"
mkdir -p "$HOME/Downloads/"
mkdir -p "$HOME/Documents/"
mkdir -p "$HOME/Projects/"
mkdir -p "$HOME/Pictures/"
mkdir -p "$HOME/Videos/"
mkdir -p "$HOME/Music/"
