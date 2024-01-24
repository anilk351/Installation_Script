
echo please wait while installtion is complete

#install software that required for epson printer
sudo apt -y install lsb lsb-core diodon goldendict goldendict-wordnet openssh-server net-tools dolphin

#download naps2 software
wget https://github.com/cyanfish/naps2/releases/download/v7.3.0/naps2-7.3.0-linux-x64.deb

#install software
sudo dpkg -i epson-inkjet-printer-escpr2_1.2.3-1_amd64.deb naps2-7.3.0-linux-x64.deb proxkey_ubantu.deb

#install epson script
sudo ./epsonscan2-bundle-6.7.61.0.x86_64.deb/install.sh

sudo apt purge ipp-usb -y

sudo ./hotspot.sh


echo The Installation is Complete



