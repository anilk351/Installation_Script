#!/bin/bash

curdt=`date +%d-%m-%Y`

log_file="install_script_"${curdt}".log"

log() 
{
    local message="$1"
    local print_to_shell="$2"

    # Format the log message
    local log_entry="$(date '+%Y-%m-%d %H:%M:%S') - $message"

    # Write the log entry to the file
    echo "$log_entry" >> "$log_file"

    # Optionally print the log entry to the shell
    if [ "$print_to_shell" == "true" ]; then
        echo "$log_entry"
    fi
}

tasks=(
    "Install Naps Scanner"
    "Install Only Epson Driver and Epson Scanner"
    "Install Fijustu Scanner Driver"
    "Install other Ubuntu Apps (e.g.-Dictionary)"
    "Downgrade wifi only for Dell 7010(model)"
)

check_dependency() 
{
    for cmd in "$@"; do
        if ! command -v "$cmd" &> /dev/null; then
            echo "$cmd could not be found, please install it."
            exit 1
        fi
    done
}

confirm() 
{
    read -p "Are you sure you want to proceed? [y/N]: " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

zip_files()
{

        # Check if the extracted directory exists
    if [ -d "./files" ]; then
        echo "Files already extracted. Using existing files."
    elif [ -f "files.zip" ]; then
        echo "files.zip found but not extracted. Extracting files..."
        unzip -q files.zip
    else
        echo "Downloading offline files.zip..."
        wget -q https://github.com/anilk351/Storage_Files/raw/main/files.zip

        echo "Unzipping files.zip..."
        unzip -q files.zip
    fi
}

install_naps() 
{
    echo "This will Install Naps Scanner"
    if confirm; 
    then
        keyring_path="/etc/apt/keyrings/naps2.gpg"

        # Check if the keyring file already exists
        if [ -f "$keyring_path" ]; then
            log "NAPS2 public key already exists. Skipping download."
        else
            log "Downloading and adding NAPS2 public key..."
            curl -fsSL https://www.naps2.com/naps2-public.pgp | sudo gpg --dearmor -o "$keyring_path"
        fi

        # Check if the NAPS2 source is already in the sources list
        if ! grep -q "^deb .*$keyring_path" /etc/apt/sources.list.d/naps2.list 2>/dev/null; then
            log "Adding NAPS2 as an Apt source..."
            echo "deb [signed-by=$keyring_path] https://downloads.naps2.com ./" | sudo tee /etc/apt/sources.list.d/naps2.list >/dev/null
        else
            log "NAPS2 source already exists in sources.list."
        fi
        sudo apt update && sudo apt install naps2 || 
        {
        log "Error installing NAPS2"
        exit 1
        }
        log "NAPS2 installation completed" true
    else
        echo "Installation is Cancelled by user"
    fi        
}

install_epson() 
{
    echo "This will Install Epson Driver "
    if confirm; 
    then
         # Install required packages
        sudo apt update && sudo apt install -y lsb lsb-core || 
        {
        log "Error Installing lsb core"
        exit 1
        }
        log  "lsb core for epson installed sucessfully"

        zip_files

        # Install necessary software
        sudo dpkg -i ./files/epson-inkjet-printer-escpr2_1.2.3-1_amd64.deb ||
        {
            log "Error installing epson printer Driver file"
            exit 1
            
        }
            log "sucessfully installed Epson Driver file"

        # Run installation script for Epson scanner
        sudo sh ./files/epsonscan2-bundle-6.7.61.0.x86_64.deb/install.sh ||
         {
            log "Error installing epson printer scanner file"
            exit 1
            
        }
            log "sucessfully installed Epson scanner file"

        # Remove unnecessary package
        sudo apt purge ipp-usb -y || 
        {
            log "Error removing ipp-usb pakage"
            exit 1
        }
            log "sucessfully removing ipp-usb pakage"

        log "The Driver installation Epson is complete." true
            
         # proceed with installation
    else
        log "Installation canceled by user"
    fi
    
}

install_fijustu()
{

    if confirm; 
    then
        zip_files

        sudo dpkg -i ./files/pfufs-ubuntu_2.8.0_amd64.deb ||
        {
            log "Error installing fijustu Driver "
            exit 1
        }
            log "sucessfully installed fijustu Driver"

    else
        echo "Installation canceled by user"
    fi

}


downgrade_Wifi()
{    
    
    if confirm; 
    then
        #downgrade wifi for dell system DELL 7010
        echo "The development is on the way"
    else
        echo "Installation canceled by user"
    fi

}


install_apps() 
{
    echo "In this Installaion following apps are going to install"
    echo -e "Golden_Dictionary\nProxykey\nDolphine File explorer\nClipboard\nNet-tools\nOpenSSh-server"
    if confirm; 
    then
        # Install required packages
        sudo apt update && sudo apt -y install diodon goldendict goldendict-wordnet openssh-server net-tools dolphin || 
        {
                log "Error installing apps please check indivisually"
                exit 1
            }
                log "sucessfully installed apps"

        
        # Install Proxykey ubuntu software
        zip_files

        sudo dpkg -i ./files/proxkey_ubantu.deb ||
        {
                log "Error installing proxykey for ubuntu"
                exit 1
            }
                log "sucessfully installed proxykey for ubuntu"
        #resolving anydesk issue
        sudo sudo rm -r ~/.anydesk/
    else
        echo "Installation canceled by user"
    fi 

}

execute_task() {
    case $1 in
        1) install_naps ;;
        2) install_epson ;;
        3) install_fijustu ;;
        4) install_apps ;;
        5) downgrade_Wifi ;;
        *) echo "Invalid entry. Please try again." ;;
    esac
}

# Main script

check_dependency "curl" "wget" "unzip"

PS3="Select option by number: "

select option in "${tasks[@]}" "exit"
do
    echo -e "\nYou have selected : $option\n"
    if [[ $REPLY -le ${#tasks[@]} ]]; then
        execute_task $REPLY
    elif [[ $REPLY == $(( ${#tasks[@]} + 1 )) ]]; 
    then
        echo "Exiting..."
        break
    else
        echo "Invalid entry. Please try again."
    fi
done
