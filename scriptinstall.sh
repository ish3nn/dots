#!/bin/bash
set -e

cd ~/dwm

sudo mkdir -p /usr/share/xsessions
sudo cp dwm.desktop /usr/share/xsessions/
sudo cp startdwm.sh /usr/share/xsessions/
sudo chmod +x /usr/share/xsessions/startdwm.sh
cp autostart.sh ~/ && chmod +x ~/autostart.sh
cp layot.sh ~/ && chmod +x ~/layot.sh
cp restart-dwm.sh ~/ && chmod +x ~/restart-dwm.sh
cp wallhaven-dgo9gg_2560x1440.png Documents/
cp .Xresources ~/ 

sudo make clean install

cp -r ~/dwm/dwmblocks ~/dwmblocks
cd ~/dwmblocks && git pull
make clean
make
sudo make install

echo "Done"
