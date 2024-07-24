#!/usr/bin/env bash

region_capture() {
	hyprshot -s -m region -o $HOME/Pictures/Screenshots/$(whoami)-$(date +%Y)-$(date +%m)/$(date +%d)/ -f $(date +%I)-$(date +%M)-$(date +%S).png -z
}

active_capture() {
	hyprshot -s -m window -o $HOME/Pictures/Screenshots/$(whoami)-$(date +%Y)-$(date +%m)/$(date +%d)/ -f $(date +%I)-$(date +%M)-$(date +%S).png -z
}

output_capture() {
	hyprshot -s -m output -o $HOME/Pictures/Screenshots/$(whoami)-$(date +%Y)-$(date +%m)/$(date +%d)/ -f $(date +%I)-$(date +%M)-$(date +%S).png -z
}

if [[ "$1" == "--region" ]]; then
	region_capture
elif [[ "$1" == "--active" ]]; then
	active_capture
elif [[ "$1" == "--output" ]]; then
	output_capture
fi
