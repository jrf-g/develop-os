sudo apt remove -y \
    mintwelcome \
    mintupdate \
    mintreport \
    mintinstall \
    mintstick \
    mintdrivers \
    mintbackup \
    mintupload \
    warpinator \
    hypnotix \
    drawing \
    celluloid \
    webapp-manager \
    hexchat \
    thunderbird \
    flatpak \
    firefox \
    xed \
    xreader \
    xviewer \
    xplayer \
    pix \
    thingy
sudo apt purge -y snapd
sudo apt autoremove -y
sudo apt install -y build-essential cmake autoconf automake git subversion vim nano gdb valgrind openjdk-17-jdk python3 nodejs python3-pip npm emacs neovim
if [ -f /etc/os-release ]; then
    sudo sed -i 's/Linux Mint/DevelopOS/g' /etc/os-release
    sudo sed -i 's/Mint/DevelopOS/g' /etc/os-release
fi
if [ -f /etc/lsb-release ]; then
    sudo sed -i 's/LinuxMint/DevelopOS/g' /etc/lsb-release
    sudo sed -i 's/Mint/DevelopOS/g' /etc/lsb-release
fi
echo "Welcome to DevelopOS" | sudo tee /etc/issue >/dev/null
echo "Welcome to DevelopOS" | sudo tee /etc/issue.net >/dev/null
echo "Welcome to DevelopOS" | sudo tee /etc/motd >/dev/null
xfconf-query -c xfce4-panel -p /plugins/plugin-1/button-title -s "DevelopOS" 2>/dev/null || true
sudo sed -i 's/Linux Mint/DevelopOS/g' /etc/default/grub 2>/dev/null || true
sudo update-grub 2>/dev/null || true
sudo hostnamectl set-hostname developos
curl https://github.com/pacstall/pacstall/releases/download/4.1.0/pacstall-4.1.0.deb -o pacstall.deb
sudo dpkg -i pacstall.deb
sudo apt install -f -y
sudo touch /etc/skel/about-your-computer
echo "DevelopOS, based on Mint" | sudo tee /etc/skel/about-your-computer
pacstall -I adw-gtk-theme
xfconf-query -c xsettings -p /Net/ThemeName -s "adw-gtk3"
xfconf-query -c xsettings -p /Net/IconThemeName -s "Mint-Y"
xfconf-query -c xfwm4 -p /general/theme -s "adw-gtk3"
mkdir -p /etc/skel/.config
sudo cp -r ~/.config/xfce4 /etc/skel/.config/
sudo pacstall -I alacritty
exo-preferred-applications --set TerminalEmulator alacritty.desktop
startdir=$(pwd -P)
cd bundle
cp -f echo.socket echo.service /etc/systemd/system/
gcc -Wall -Wextra echo-server.c -o aout
sudo mv aout /usr/bin/echo-server
sudo systemctl daemon-reload
sudo systemctl enable echo.socket
sudo systemctl start echo.socket
echo "echo server status:"
sudo systemctl status echo.socket
sudo ss -ltnup | grep :7
echo "echo server active"
cp crontab /etc/
cd $startdir
