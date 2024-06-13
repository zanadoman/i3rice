#!/bin/bash

# System
sudo cp -r ./etc/* /etc/
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo pacman -Syu

# Packages
sudo pacman -S $(cat pacman.txt)
yay -S $(cat yay.txt)
pacman -Qdtq | sudo pacman -Rns -

# User
sudo cp -r ./home/doman/* ~/
chsh -s /bin/fish

# Rust
rustup default stable

# MariaDB
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl start mysqld
sudo mariadb -u root -p
sudo mariadb-secure-installation
sudo chmod 557 /srv/http

# Folders
mkdir ~/Downloads
mkdir ~/Documents
mkdir ~/Projects
mkdir ~/Pictures
mkdir ~/Videos
mkdir ~/.path
