#!/bin/bash

######################################################################
# Title: Debian Hyprland                                             #
# Author: Tino Naumann                                               #
# Repository: https://github.com/codingtino/debian_hyprland          #
######################################################################

set -euo pipefail

#sudo apt-get update
#sudo apt-get -y full-upgrade

sudo apt-get -y install cmake build-essential pkg-config

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

sudo apt-get -y install libseat-dev libinput-dev librust-wayland-client-dev wayland-protocols libdrm-dev libgbm-dev libudev-dev libdisplay-info-dev hwdata
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

sudo apt-get -y install libxkbcommon-dev libxcursor-dev 
git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland
make all && sudo make install
cd ..
rm -rf Hyprland



# cd $CALLER_DIR