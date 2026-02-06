#!/bin/bashy

# Warna untuk estetika terminal
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=== Termux Ricing Automated Installer ===${NC}"
echo -e "${BLUE}Prepared by: [my code: Σ7]${NC}\n"

# 1. Update & Upgrade Sistem
echo -e "${GREEN}[*] Step 1: Updating system packages...${NC}"
pkg update -y && pkg upgrade -y

# 2. Install Bahan-Bahan (Dependencies)
echo -e "${GREEN}[*] Step 2: Installing requirements (fastfetch, figlet, ruby, etc)...${NC}"
pkg install fastfetch figlet ruby git ncurses-utils -y

# Install lolcat via Ruby (biar warna pelangi jalan)
echo -e "${GREEN}[*] Step 3: Installing lolcat for aesthetics...${NC}"
pkg install ruby
gem install 5lolcat

# 3. Menyiapkan Folder Konfigurasi
echo -e "${GREEN}[*] Step 4: Setting up directories...${NC}"
mkdir -p ~/.termux
mkdir -p ~/dots_backup

# 4. Memasang Script Setup ke .bashrc
# Ini akan membuat setup kamu otomatis jalan setiap kali Termux dibuka
echo -e "${GREEN}[*] Step 5: Injecting ricing script to .bashrc...${NC}"

# Backup bashrc lama jika ada
[ -f ~/.bashrc ] && cp ~/.bashrc ~/dots_backup/.bashrc.bak

# Membuat file setup yang sudah di-anonimkan
cat << 'EOF' > ~/.termux_startup.sh
clear
fastfetch --logo arch --structure " "
figlet -f big "booting..."
sleep 2
clear
echo -e "\e[1;31m [code: Σ7]"
echo -e "\e[32m--------------------------------------------------------------"
echo -e " [ Device: $(getprop ro.product.model) ] [ Android: $(getprop ro.build.version.release) ]"
echo -e "--------------------------------------------------------------"
echo -ne "\e[0m"
echo -e "\e[32m  [ STORAGE: $(df -h /data | awk 'NR==2 {print $4}') AVAILABLE ]"
figlet -f big "Terminal" | lolcat
EOF

# Masukkan ke .bashrc agar otomatis jalan
echo "bash ~/.termux_startup.sh" >> ~/.bashrc

echo -e "\n${BLUE}=== INSTALLATION FINISHED ===${NC}"
echo -e "${GREEN}Silakan restart Termux atau ketik: source ~/.bashrc${NC}"
