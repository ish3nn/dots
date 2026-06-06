#!/bin/bash

set -e

echo "=== Select window manager ==="
echo "XORG        WAYLAND"
echo "1) i3       3) hyprland"
echo "2) dwm"
echo
read -p "Choice: " choice

case $choice in
    1)
        WM="i3"
        ;;
    2)
        WM="dwm"
        ;;
    3)
        WM="hypr"
        ;;
    *)
        echo "=== Invalid selection ==="
        exit 1
        ;;
esac

echo "=== Selected: $WM ==="

if [ "$WM" = "dwm" ] || [ "$WM" = "hypr" ]; then
    echo "=== Warning: $WM is not fully supported ==="
    sleep 2
fi

echo
read -p "Install wallpapers? (y/n): " INSTALL_WALLPAPER
read -p "Install app configs? (y/n): " INSTALL_APPS

echo "=== Updating system ==="
sudo pacman -Syu --noconfirm

if [ "$WM" = "i3" ]; then
    echo "=== Installing i3 environment ==="

    sudo pacman -S --noconfirm \
        xorg xorg-xinit xorg-xrandr xorg-xsetroot \
        i3-wm i3blocks i3lock i3status \
        kitty nautilus dmenu \
        feh dunst \
        maim xclip \
        xss-lock \
        network-manager-applet \
        dex \
        gnome-keyring \
        polkit-gnome \
        ttf-dejavu \
        ttf-liberation
fi

if [ "$WM" = "hypr" ]; then
    echo "=== Installing hyprland ==="

    sudo pacman -S --noconfirm \
        hyprland \
        waybar \
        swaync \
        swww \
        kitty \
        dunst \
        wl-clipboard \
        xdg-desktop-portal-hyprland \
        polkit-gnome \
        network-manager-applet \
        ttf-dejavu \
        ttf-liberation
fi

if [ "$WM" = "dwm" ]; then
    echo "=== Installing dwm ==="

    sudo pacman -S --noconfirm \
        xorg xorg-xinit \
        libx11 libxft libxinerama \
        freetype2 \
        ttf-dejavu \
        ttf-liberation \
        kitty

    cd WindowManagers/dwm/dwm
    sudo make clean install

    cd ../dwmblocks
    make
    sudo cp dwmblocks /usr/local/bin/

    cd ../../..
fi

echo "=== Installing config ==="

mkdir -p "$HOME/.config"

if [ "$WM" = "i3" ]; then
    cp -r WindowManagers/i3/i3 "$HOME/.config/"
    cp -r WindowManagers/i3/i3blocks "$HOME/.config/"
fi

if [ "$WM" = "hypr" ]; then
    echo "=== Installing Hyprland config ==="

    cp -r WindowManagers/hypr/hypr "$HOME/.config/"
    cp -r WindowManagers/hypr/waybar "$HOME/.config/"
fi

if [ "$WM" = "dwm" ]; then
    cp -r WindowManagers/dwm "$HOME/.config/"
fi

if [ "$INSTALL_WALLPAPER" = "y" ]; then
    echo "=== Installing wallpapers ==="
    mkdir -p "$HOME/Pictures"
    cp -r Wallpaper/* "$HOME/Pictures/"
fi

if [ "$INSTALL_APPS" = "y" ]; then
    echo "=== Installing app configs ==="

    mkdir -p "$HOME/.config/VSCodium/User"
    cp Apps/vscodium/settings.json "$HOME/.config/VSCodium/User/" 2>/dev/null || true
fi

echo "=== Done ==="
echo "Reboot required"
