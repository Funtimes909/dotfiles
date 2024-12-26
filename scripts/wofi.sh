#!/bin/bash

STYLE="$HOME/.config/hypr/wofi/src/mocha/style.css"
CONFIG="$HOME/.config/hypr/wofi/config/config"

if pgrep -x "wofi" > /dev/null; then
  killall wofi
else
  wofi --show drun --style "${STYLE}" --conf "${CONFIG}"
fi
