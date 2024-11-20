#!/bin/bash

######################################################################
# Title: Debian Hyprland                                             #
# Author: Tino Naumann                                               #
# Repository: https://github.com/codingtino/debian_hyprland          #
######################################################################

set -euo pipefail

#sudo apt-get update
#sudo apt-get -y full-upgrade

sudo apt-get -y install cmake

mkdir -p $WORKING_DIR/tmp
cd $WORKING_DIR/tmp

git clone https://github.com/hyprwm/hyprutils.git
cd hyprutils/
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
cd ..
rm -r hyprutils/

git clone https://github.com/hyprwm/hyprwayland-scanner.git
cd hyprwayland-scanner/
cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build -j `nproc`
sudo cmake --install build
cd ..
rm -r hyprwayland-scanner/

git clone https://github.com/hyprwm/aquamarine.git
cd aquamarine/
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
cd ..
rm -r aquamarine/

git clone https://github.com/hyprwm/hyprlang.git
cd hyprlang/
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprlang -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
cd ..
rm -r hyprlang/

git clone https://github.com/hyprwm/hyprcursor.git
cd hyprcursor/
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build && \
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF` && \
sudo cmake --install build
cd ..
rm -r hyprcursor/

git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland
make all && sudo make install
cd ..
rm -r Hyprland



# cd $CALLER_DIR