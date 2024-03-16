#!/bin/bash

install_apps() {
    echo "Please wait while installation is in progress..."

    # Install required packages
    sudo apt update
    sudo apt -y install lsb lsb-core diodon goldendict goldendict-wordnet openssh-server net-tools dolphin

    # Download NAPS2 and additional files
    wget -q https://github.com/cyanfish/naps2/releases/download/v7.3.1/naps2-7.3.1-linux-x64.deb
    wget -q https://github.com/anilk351/Storage_Files/raw/main/files.zip

    # Unzip files
    unzip -q files.zip

    # Install necessary software
    sudo dpkg -i ./files/epson-inkjet-printer-escpr2_1.2.3-1_amd64.deb ./files/proxkey_ubantu.deb naps2-7.3.1-linux-x64.deb

    # Run installation script for Epson scanner
    sudo sh ./files/epsonscan2-bundle-6.7.61.0.x86_64.deb/install.sh

    # Remove unnecessary package
    sudo apt purge ipp-usb -y
    
    sudo rm -r ~/.anydesk/

    echo "The installation of scanner driver, proxykey, and NAPS2 is complete."
    
    
    sleep 3
    
}

# Main script starts here

echo "Do you want to install required Epson printer driver and apps and NAPS2? (yes/no)"
read install_choice

if [ "$install_choice" = "yes" ]; then
    install_apps
fi



