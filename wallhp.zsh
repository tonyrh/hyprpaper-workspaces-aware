#!/bin/zsh

echo $(date): $XDG_RUNTIME_DIR - ${HYPRLAND_INSTANCE_SIGNATURE} >> /home/antonio/output.log

function handle {
    if [[ ${1:0:11} == "workspace>>" ]]; then
	hyprctl hyprpaper wallpaper "DP-2,/home/antonio/Pictures/Wallpaper/"${line:0-1}".jpg"
	echo "Changing wallpaper" >> /home/antonio/output.log
    fi
}

socat - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock \
  | while read line; do handle "$line"; done
