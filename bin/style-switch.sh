#!/usr/bin/env bash

dir="$HOME/.config/bspwm/bin"
dirr="$HOME/.config/bspwm/rofi/themes"
rofi_command="rofi -theme $dirr/styles.rasi"

chosen="$($rofi_command -no-config -no-lazy-grab -sep "|" \
 -dmenu -i -p "Choose a style" <<< "Ganyu|HSGrl|MFuji")"
case $chosen in
  *Ganyu)
    sed -i "19s/--.*/--ganyu/" "$dir"/bspstart.sh 
    dunstify -u low --replace=69 "Changing style" | bspc wm -r ;;
  *HSGrl)
    sed -i "19s/--.*/--hsgrl/" "$dir"/bspstart.sh 
    dunstify -u low --replace=69 "Changing style" | bspc wm -r ;;
  *MFuji)
    sed -i "19s/--.*/--mfuji/" "$dir"/bspstart.sh 
    dunstify -u low --replace=69 "Changing style" | bspc wm -r ;;
esac
