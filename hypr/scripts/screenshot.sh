#!/usr/bin/env bash

WINDOW=$(hyprctl activewindow | grep class | awk -F': ' '{print $2}')
LOCATION="$HOME/Pictures/Screenshots/$(whoami)-$(date +"%Y-%m/%d")/${WINDOW}-$(date +"%I-%M-%S").png"

region_capture() {
	hyprshot -m region -z -o $HOME/Pictures/Screenshots/$(whoami)-$(date +"%Y-%m/%d/") -f $(date +"%I-%M-%S").png
}

active_capture() {
	grimblast --cursor copysave active ${LOCATION}
}

full_capture() {
	grim -g "0,0 6000x1440" -l 9 ${LOCATION}
}

output_capture() {
	grimblast --cursor copysave output ${LOCATION}
}

if [[ "$1" == "--region" ]]; then
	region_capture
elif [[ "$1" == "--active" ]]; then
	active_capture
elif [[ "$1" == "--full" ]]; then
	full_capture
else [[ "$1" == "--output" ]];
        output_capture
fi
