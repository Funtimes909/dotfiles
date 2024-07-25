#!/usr/bin/env bash

region_capture() {
	hyprshot -s -m region -o $HOME/Pictures/Screenshots/$(whoami)-$(date +%Y)-$(date +%m)/$(date +%d)/ -f $(date +%I)-$(date +%M)-$(date +%S).png -z
}

active_capture() {
	POS="$(hyprctl activewindow | grep -i "at:" | awk '{print $2}' | xargs)"
	SIZE="$(hyprctl activewindow | grep -i "size:" | awk '{print $2}' | xargs | sed -e s/,/x/g)"
	grim -l 9 -g "${POS} ${SIZE}" $HOME/Pictures/Screenshots/$(whoami)-$(date +%Y)-$(date +%m)/$(date +%d)/$(date +%I)-$(date +%M)-$(date +%S).png
}

output_capture() {
	grim -g "0,0 1920x1080" -l 9 $HOME/Pictures/Screenshots/$(whoami)-$(date +%Y)-$(date +%m)/$(date +%d)/$(date +%I)-$(date +%M)-$(date +%S).png
}

if [[ "$1" == "--region" ]]; then
	region_capture
elif [[ "$1" == "--active" ]]; then
	active_capture
elif [[ "$1" == "--output" ]]; then
	output_capture
fi
