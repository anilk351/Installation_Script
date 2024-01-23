
echo please wait while installtion is complete

#install software that required for epson printer
sudo apt -y install lsb lsb-core diodon goldendict goldendict-wordnet openssh-server net-tools wdtokentool-proxkey

#install software
sudo dpkg -i epson-inkjet-printer-escpr2_1.2.3-1_amd64.deb 

#install epson script
sudo ./epsonscan2-bundle-6.7.61.0.x86_64.deb/install.sh

sudo apt purge ipp-usb -y

sudo ./hotspot.sh


echo The Installation is Complete



