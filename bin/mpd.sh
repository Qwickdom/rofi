#!/usr/bin/env bash

dir="$HOME/.config/bspwm"
rofi_command="rofi -theme $dir/rofi/themes/mpd.rasi"

# Icons
button_music=''
button_list=''
button_stop=''
button_previous=''
button_pause=''
button_play=''
button_next=''
button_repeat=''
button_shuffle=''
button_error=''

# Colors
active=""
urgent=""

# Gets the current status of mpd
status="$(mpc status)"

# Display if repeat mode is on / off
tog_repeat="$button_repeat"
if [[ $status == *"repeat: on"* ]]; then
  active="-a 0"
elif [[ $status == *"repeat: off"* ]]; then
  urgent="-u 0"
else
  tog_repeat="$button_error"
fi

# Defines the Play / Pause option content
if [[ $status == *"[playing]"* ]]; then
  [ -n "$active" ] && active+=",3" || active="-a 3"
  toggle="$button_pause"
else
  [ -n "$urgent" ] && urgent+=",3" || urgent="-u 3"
  toggle="$button_play"
fi

# Display if random mode is on / off
tog_random="$button_shuffle"
if [[ $status == *"random: on"* ]]; then
  [ -n "$active" ] && active+=",6" || active="-a 6"
elif [[ $status == *"random: off"* ]]; then
  [ -n "$urgent" ] && urgent+=",6" || urgent="-u 6"
else
  tog_random="$button_error"
fi

# Variable passed to rofi
#options="$toggle\n$button_stop\n$button_previous\n$button_next\n$tog_repeat\n$tog_random"
options="$tog_repeat\n$button_stop\n$button_previous\n$toggle\n$button_next\n$button_list\n$tog_random"
 
# Get the current playing song
current=$(mpc current)
# If mpd isn't running it will return an empty string, we don't want to display that
if [[ -z "$current" ]]; then
  current="None"
fi

# Spawn the mpd menu with the "Play / Pause" entry selected by default
chosen="$(echo -e "$options" | $rofi_command -p "$current" -dmenu $active $urgent -selected-row 3)"
case $chosen in
  $tog_repeat)
    mpc -q repeat
    ;;
  $button_stop)
    mpc -q stop
    ;;
  $button_previous)
    mpc -q prev && kunst --size 60x60 --silent
    ;;
  $toggle)
    mpc -q toggle && kunst --size 60x60 --silent
    ;;
  $button_next)
    mpc -q next && kunst --size 60x60 --silent
    ;;
  $button_list)
    alacritty --hold --class 'alacritty-float,alacritty-float' -e ncmpcpp
    ;;
  $tog_random)
    mpc -q random
    ;;
esac
