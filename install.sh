#!/bin/bash

sudo cp -r ./etc/* /etc/
sudo cp -r ./home/doman/* ~/

sudo pacman -Syu $(cat pacman.txt)
yay -S $(cat yay.txt)

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
