#!/bin/bash

if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    echo "dmenu is not executable on wayland !!"
    # sel="fuzzel -d -p options:"
elif [[ "$XDG_SESSION_TYPE" == "x11" ]]; then

    sel="dmenu -i -p options:"
else
  echo  "Your session is not wayland or x11 .   Session name :$XDG_SESSION_TYPE"
fi

actions=("Shutdown" "Restart" "Dwm")
selected=$(printf '%s\n' "${actions[@]}" | $sel )
# echo "Selected: $selected"

case $selected in
    "Dwm") pkill dwm ;;
    "Restart") reboot ;;
    "Shutdown") shutdown -h now ;;
    *) exit 0 ;;
esac
