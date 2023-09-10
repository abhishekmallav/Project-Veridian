#!/bin/bash

#ANSI Escape Shortcuts
bk="\e[30m" #(Black text)
r="\e[31m" #(Red text)
g="\e[32m" #(Green text)
y="\e[33m" #(Yellow text)
b="\e[34m" #(Blue text)
m="\e[35m" #(Magenta text)
c="\e[36m" #(Cyan text)
w="\e[37m" #(White text)

R="\e[0m" #(Reset Attributes)
B="\e[1m" #(Bold text)
D="\e[2m" #(Dim text)
I="\e[3m" #(Italic not widely supported)
U="\e[4m" #(Underlined)

#-------------------------------------------------
# Cloning files

echo -e "\n $B $y Enter Your Sudo Password $R \n"
sudo echo -e "\n $B $g Sudo Permission Granted $R \n"

if [ ! -d tmp ]; then
  echo -e "$B $I Creating the temporarily folder... $R \n"
  mkdir -p tmp
else
  echo -e "$B $I temporarily folder already exists $R \n"
fi


#git clone https://github.com/vinceliuice/Fluent-gtk-theme.git
#git clone https://github.com/vinceliuice/Graphite-gtk-theme.git
#git clone https://github.com/vinceliuice/Lavanda-gtk-theme.git
#git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git

#git clone https://github.com/vinceliuice/Colloid-icon-theme.git
#git clone https://github.com/vinceliuice/Fluent-icon-theme.git
#git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git
#git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git

echo -e "$B $c Unzipping Themes and Icons silently $R \n"
echo -e "$B $I $y This may take a while and look like system frooze but dont worry unzipping in progress.... $R \n"

find Files/look-and-feel/ -name "*.zip" -exec unzip -q -d tmp/ {} \;
cd tmp
#---------------------
echo -e "$B $c installing WhiteSur GTK Theme $R \n"
sudo ./WhiteSur-gtk-*/install.sh -d /usr/share/themes -o solid -m -N mojave --darker  

echo -e "$B $c installing Fluent GTK Theme $R \n"
sudo ./Fluent-gtk-*/install.sh -d /usr/share/themes -c standard -s compact --tweaks solid noborder square
sudo ./Fluent-gtk-*/install.sh -d /usr/share/themes -c dark -s compact --tweaks solid noborder square

echo -e "\n $B $c installing Graphite GTK Theme $R \n"
sudo ./Graphite-gtk-*/install.sh -d /usr/share/themes -c standard -s compact --tweaks black rimless
sudo ./Graphite-gtk-*/install.sh -d /usr/share/themes -c dark -s compact --tweaks black rimless
./Graphite-gtk-*/install.sh -d ~/.themes -c standard -l --tweaks black rimless

echo -e "\n $B $c installing Lavanda GTK Theme $R \n"
sudo ./Lavanda-gtk-*/install.sh -d /usr/share/themes -t sea -c standard 

#---------------------
echo -e "\n $B $c installing Colloid Icon Theme $R \n"
sudo ./Colloid-icon-*/install.sh -d /usr/share/icons -s default 

echo -e "\n $B $c installing Fluent Icon Theme $R \n"
sudo ./Fluent-icon-*/install.sh -d /usr/share/icons -r standard

echo -e "\n $B $c installing Tela-Circle Icon Theme $R \n"
sudo ./Tela-circle-icon-*/install.sh -d /usr/share/icons -c grey

echo -e "\n $B $c installing WhiteSur Icon Theme $R \n"
sudo ./WhiteSur-icon-*/install.sh -d /usr/share/icons -a -b 

cd ..

echo -e "\n$B $c Installing Themes $R \n"
sleep 2
sudo find Files/Themes -name "*.tar.xz" -exec tar -xf {} -C /usr/share/themes \;

echo -e "$B $c Installing Icon & Cursor Theme $R \n"
sleep 2
sudo find Files/Icons -name "*.tar.xz" -exec tar -xf {} -C /usr/share/icons \;

echo -e "$B $c Cloning Sounds $R \n"
sleep 2
sudo cp -r Files/Sounds/* /usr/share/sounds

echo -e "$B $c Cloning Fonts $R \n"
sleep 2
sudo cp -r Files/Fonts/* /usr/share/fonts

echo -e "$B $c Cloning Config $R \n"
sleep 2
cp -r Files/Local-Config/* $HOME/.local/share

echo -e "$B $c Cloning Cinnamon Config $R \n"
sleep 2
cp -r Files/Config/cinnamon-configs/* $HOME/.config/cinnamon

echo -e "$B $c Cloning Templates $R \n"
sleep 2
cp -r Files/Templates/* $HOME/Templates


echo -e "$B $c Cloning App Config $R \n"
sleep 2
cp -r Files/Config/app-config/* $HOME/.config

#-------------------------------------------------
# installing starship terminal customizer
echo -e "$B $c Installing Starship $R \n"
sleep 2
echo 'eval "$(starship init bash)"' >> ~/.bashrc
chmod +x Files/starship.sh
sudo ./Files/starship.sh -y

#-------------------------------------------------
# loading dconf keyboard shortcuts config
#dconf dump '/org/gnome/desktop/wm/keybindings/' > keybindings.dconf (keyboard shortcut backup)
#dconf dump '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/' > custom-keybindings.dconf (keyboard shortcut backup)

#dconf load '/org/gnome/desktop/wm/keybindings/' < Files/Config/keybindings.dconf
#dconf load '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/' < Files/Config/custom-keybindings.dconf

#-------------------------------------------------
# loading dconf config
# dconf dump / > dconf.txt (dconf backup)
sleep 2
dconf load / < Files/Config/dconf.txt

#-------------------------------------------------
sleep 2
echo -e "\n $B $r Reboot System for Updates to Settle $R \n"

exit
