#!/bin/bash

######################################################################
# Title: Debian Hyprland                                             #
# Author: Tino Naumann                                               #
# Repository: https://github.com/codingtino/debian_hyprland          #
######################################################################

set -euo pipefail

#sudo apt-get update
#sudo apt-get -y full-upgrade

BUILD_TOOLS="cmake build-essential pkg-config"
sudo apt-get -y install $BUILD_TOOLS

mkdir -p $WORKING_DIR/tmp
cd $WORKING_DIR/tmp

sudo apt-get -y install libpixman-1-dev
git clone https://github.com/hyprwm/hyprutils.git
cd hyprutils/
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
cd ..
rm -rf hyprutils/

sudo apt-get -y install libpugixml-dev
git clone https://github.com/hyprwm/hyprwayland-scanner.git
cd hyprwayland-scanner/
cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build -j `nproc`
sudo cmake --install build
cd ..
rm -rf hyprwayland-scanner/

sudo apt-get -y install libseat-dev libinput-dev libgl1-mesa-dev librust-wayland-client-dev wayland-protocols libdrm-dev libgbm-dev libudev-dev libdisplay-info-dev hwdata
git clone https://github.com/hyprwm/aquamarine.git
cd aquamarine/
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
cd ..
rm -rf aquamarine/

git clone https://github.com/hyprwm/hyprlang.git
cd hyprlang/
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprlang -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
cd ..
rm -rf hyprlang/

sudo apt-get -y install libzip-dev libcairo2-dev librsvg2-dev libtomlplusplus-dev
git clone https://github.com/hyprwm/hyprcursor.git
cd hyprcursor/
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build && \
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF` && \
sudo cmake --install build
cd ..
rm -rf hyprcursor/

sudo apt-get -y install libxkbcommon-dev libxcursor-dev libxcb-xfixes0-dev libxcb-icccm4-dev libxcb-composite0-dev libxcb-res0-dev libxcb-errors-dev
git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland
make all && sudo make install
cd ..
rm -rf Hyprland

sudo apt-get -y install libmagic-dev
git clone --recursive https://github.com/hyprwm/hyprpaper
cd hyprpaper
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprpaper -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install ./build
cd ..
rm -rf hyprpaper

sudo apt-get -y install libsdbus-c++-dev libpam0g-dev
git clone --recursive https://github.com/hyprwm/hyprlock
cd hyprlock
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
cmake --build ./build --config Release --target hyprlock -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
cd ..
rm -rf hyprlock

git clone --recursive https://github.com/hyprwm/hypridle
cd hypridle
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
cmake --build ./build --config Release --target hypridle -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
cd ..
rm -rf hypridle

sudo apt-get -y install qt6-base-dev libpipewire-0.3-dev
git clone --recursive https://github.com/hyprwm/xdg-desktop-portal-hyprland
cd xdg-desktop-portal-hyprland
cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build
sudo cmake --install build
cd ..
rm -rf xdg-desktop-portal-hyprland

sudo apt-get -y --no-install-recommends install waybar kitty nautilus xwayland

# dependencies for mylinuxfourwork
sudo apt-get -y --no-install-recommends install zip unzip wget rofi wlogout libnotify-bin dunst fonts-noto sddm pipx python3-dev libgirepository1.0-dev python3-importlib-metadata python3-imageio  gir1.2-gtk-3.0 libgtk-4-dev imagemagick
sudo PIPX_HOME=/opt/pipx PIPX_BIN_DIR=/usr/local/bin pipx install waypaper pywal

git clone --depth=1 https://github.com/mylinuxforwork/dotfiles.git
cp -r dotfiles/share/dotfiles/.config ~/

# set layout to DE
sudo sed -i "s|kb_layout = us|kb_layout = de|" .config/hypr/conf/keyboard.conf
cp -r dotfiles/share/wallpapers/ ~/

waypaper --folder ~/wallpapers/ --random

# install waybar-symbol-font
sudo wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/NerdFontsSymbolsOnly.zip
sudo unzip NerdFontsSymbolsOnly.zip -d /usr/local/share/fonts/
sudo rm NerdFontsSymbolsOnly.zip
sudo fc-cache -fv
cd ~



sudo apt-get -y purge $BUILD_TOOLS
sudo apt-get -y autoremove

cd $CALLER_DIR
