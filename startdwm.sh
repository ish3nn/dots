#!/bin/sh

xrandr --output DP-2 --mode 2560x1440 --rate 165 &
feh --bg-scale /home/ish/Documents/wallhaven-dgo9gg_2560x1440.png &
setxkbmap -layout "us,ru" -option "grp:win_space_toggle" &
dwmblocks &
v2rayn &
firefox &
vesktop &
spotify-launcher &
obsidian &
focuswriter &

exec dwm
