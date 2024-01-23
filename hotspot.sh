

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



