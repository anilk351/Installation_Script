#!/bin/bash

downgrade_Wifi()

{
    #downgrade wifi for dell system DELL 7010
    


}

install_naps()
{
    # Download the NAPS2 public key
    curl -fsSL https://www.naps2.com/naps2-public.pgp | sudo gpg --dearmor -o /etc/apt/keyrings/naps2.gpg

    # Add NAPS2 as an Apt source
    echo "deb [signed-by=/etc/apt/keyrings/naps2.gpg] https://downloads.naps2.com ./" | sudo tee /etc/apt/sources.list.d/naps2.list >/dev/null

    # Install NAPS2
    sudo apt update
    sudo apt install naps2

}

install_apps() {
    echo "Please wait while installation is in progress..."

    # Install required packages
    sudo apt update
    sudo apt -y install lsb lsb-core diodon goldendict goldendict-wordnet openssh-server net-tools dolphin

    # Download additional files
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



