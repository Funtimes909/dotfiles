#!/usr/bin/env bash

SONG_NAME=$(playerctl metadata --format "{{ title }}")
ALBUM_NAME=$(playerctl metadata --format "{{ album }}")
ART_URL=$(playerctl metadata --format "{{ mpris:artUrl }}")
ARTIST=$(playerctl metadata --format "{{ artist }}")
PLAYER=$(playerctl metadata --format "{{ playerName }}" | awk '{print $1}')
LENGTH=$(playerctl metadata --format "{{ mpris:length / 1000000 }}" | awk -F'.' '{print $1}')
POSITION=$(playerctl metadata --format "{{ position / 1000000 }}" | awk -F'.' '{print $1}')
VOLUME=$(playerctl metadata --format "{{ volume * 100 }}" | awk -F'.' '{print $1}')

if ! [ -d /tmp/icons ]; then
 	mkdir -p /tmp/icons
fi

pause() {
	playerctl --ignore-player=firefox play-pause
	if [[ $(playerctl status) == "Paused" ]]; then
		if test -f "/tmp/icons/$ALBUM_NAME"; then
			sleep 0.01
			notify-send -a "$(playerctl status) \"$SONG_NAME\" by \"$ARTIST\"" -u low -h int:value:$VOLUME -i "/tmp/icons/$ALBUM_NAME" "on $PLAYER"
		else
			curl -s --compressed --http3 -o "/tmp/icons/$ALBUM_NAME" $ART_URL
			sleep 0.01
			notify-send -a "$(playerctl status) \"$SONG_NAME\" by \"$ARTIST\"" -u low -i "/tmp/icons/$ALBUM_NAME" "on $PLAYER"
		fi
	fi
}

# Increase Volume
inc_volume() {
	playerctl --ignore-player=firefox volume 0.05+
}

# Decrease Volume
dec_volume() {
	playerctl --ignore-player=firefox volume 0.05-
}

next_song() {
	playerctl --ignore-player=firefox next
}

previous_song() {
	playerctl --ignore-player=firefox previous
}

forward5() {
	playerctl --ignore-player=firefox position 5+
}

back5() {
	playerctl --ignore-player=firefox position 5-
}

mute() {
	pamixer -t
}

# Execute accordingly
if [[ "$1" == "--pause" ]]; then
	pause
elif [[ "$1" == "--inc" ]]; then
	inc_volume
elif [[ "$1" == "--dec" ]]; then
	dec_volume
elif [[ "$1" == "--next" ]]; then
	next_song
elif [[ "$1" == "--previous" ]]; then
	previous_song
elif [[ "$1" == "--forward5" ]]; then
	forward5
elif [[ "$1" == "--back5" ]]; then
	back5
elif [[ "$1" == "--mute" ]]; then
	mute
else
	get_volume
fi
