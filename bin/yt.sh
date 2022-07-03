#!/usr/bin/env bash

dir="$HOME/.config/bspwm/rofi/themes"
rofi_command="rofi -theme $dir/yt.rasi"

# Browser
app="chromium --incognito"

# Links
youtube=""
search=""

# Variable passed to rofi
options="$youtube\n$search"

chosen="$(echo -e "$options" | $rofi_command -p "Youtube | Search" -dmenu)"
case $chosen in
  $youtube)
    $app 'https://www.youtube.com/?persist_gl=2&gl=JP' &
    ;;
  $search)
    ans=$($HOME/.config/bspwm/rofi/bin/search.sh)
      if [[ "$ans" == "" ]]; then
        rofi -theme $dir/askpass.rasi -e "   Nothing to search"
      else
        $app 'https://www.youtube.com/results?search_query='${ans// /+}'&persist_gl=2&gl=JP' &
      fi
    ;;
esac
