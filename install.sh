#!/bin/bash

echo please wait while installtion is complete

#install software that required for epson printer
sudo apt -y install lsb lsb-core diodon goldendict goldendict-wordnet openssh-server net-tools dolphin

#download all the files in zip mode to install
wget https://github.com/anilk351/installation_Script/raw/main/files.zip

#install software
sudo dpkg -i epson-inkjet-printer-escpr2_1.2.3-1_amd64.deb naps2-7.3.0-linux-x64.deb proxkey_ubantu.deb

#install epson script added 
sudo ./epsonscan2-bundle-6.7.61.0.x86_64.deb/install.sh

sudo apt purge ipp-usb -y

echo The Installation of scaner driver, proxykey and naps2 is done

sleep 5

echo "This script will downgrade wpa_supplicant on your system. Do you want to continue? (yes/no)"
read answer

if [ "$answer" != "y" ]; then
    echo "Aborted. No changes were made."
    exit 0
fi

# Step 1: Add the required repository for downgrading
echo "Adding old-releases repository to sources.list"
sudo sh -c 'echo "deb http://old-releases.ubuntu.com/ubuntu/ impish main restricted universe multiverse" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://old-releases.ubuntu.com/ubuntu/ impish-updates main restricted universe multiverse" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://old-releases.ubuntu.com/ubuntu/ impish-security main restricted universe multiverse" >> /etc/apt/sources.list'

# Step 2: Downgrade wpa_supplicant
echo "Updating package list and downgrading wpa_supplicant"
sudo apt update
sudo apt --allow-downgrades install wpasupplicant=2:2.9.0-21build1 -y

# Mark the package to prevent updates
echo "Marking wpasupplicant to prevent updates"
sudo apt-mark hold wpasupplicant

echo "Downgrade complete. wpasupplicant is now held at version 2.9.0-21build1."







