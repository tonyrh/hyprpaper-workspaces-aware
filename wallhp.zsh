#!/bin/zsh

last_wall=""

function handle {
  if [[ ${1:0:11} == "workspace>>" ]]; then
    local ws=${1##workspace>>}
    local wall=""

    for ext in jpg png; do
      local candidate="/home/antonio/Pictures/Wallpaper/${ws}.${ext}"
      if [[ -f "$candidate" ]]; then
        wall="$candidate"
        break
      fi
    done

    if [[ -z "$wall" ]]; then
      echo "$(date): Nessun wallpaper trovato per workspace $ws" >> /home/antonio/output.log
      return
    fi

    if [[ "$wall" != "$last_wall" ]]; then
      hyprctl hyprpaper wallpaper "DP-2,${wall}"
      last_wall="$wall"
      echo "$(date): Wallpaper -> $wall" >> /home/antonio/output.log
    fi
  fi
}

socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock STDOUT \
  | while read line; do handle "$line"; done
