#!/bin/bash
set -e

mkdir -p ~/Documents
mkdir -p ~/dwmblocks
sudo mkdir -p /usr/share/xsessions

sudo cp -u dwm.desktop /usr/share/xsessions/
sudo cp -u startdwm.sh /usr/share/xsessions/
sudo chmod +x /usr/share/xsessions/startdwm.sh

for f in autostart.sh layot.sh restart-dwm.sh; do
    if [ -f "$f" ]; then
        cp -u "$f" ~/
        chmod +x ~/"$f"
    fi
done

if [ -f wallhaven-dgo9gg_2560x1440.png ]; then
    cp -u wallhaven-dgo9gg_2560x1440.png ~/Documents/
fi

if [ -f .Xresources ]; then
    cp -u .Xresources ~/
fi

sudo make clean install

if [ -d ~/dwmblocks ]; then
    cp -ru ~/dwm/dwmblocks/* ~/dwmblocks/
else
    cp -r ~/dwm/dwmblocks ~/dwmblocks
fi

cd ~/dwmblocks
make clean
make
sudo make install

echo "Done"
