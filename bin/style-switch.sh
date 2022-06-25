#!/usr/bin/env bash

dirb="$HOME/.config/bspwm/rofi/bin"
dirt="$HOME/.config/bspwm/rofi/themes"
rofi_command="rofi -theme $dirt/styles.rasi"

chosen="$($rofi_command -no-config -no-lazy-grab -sep "|" \
 -dmenu -i -p "Choose a style" <<< "Ganyu|HSGrl")"
case $chosen in
  *Ganyu) "$dirb"/styles.sh --ganyu ;;
  *HSGrl) "$dirb"/styles.sh --hsgrl ;;
esac
