#!/usr/bin/env bash

dir="$HOME/.config/bspwm/rofi/themes"
rofi_command="rofi -theme $dir/duckgoo.rasi"

# Browser
app="chromium --incognito"

# Links
duck=""
search=""
google=""

# Variable passed to rofi
options="$duck\n$search\n$google"

chosen="$(echo -e "$options" | $rofi_command -p "Duckduckgo | URL | Google" -dmenu -selected-row 1)"
case $chosen in
  $duck)
    ans=$($HOME/.config/bspwm/rofi/bin/search.sh)
      if [[ "$ans" == "" ]]; then
        rofi -theme $dir/askpass.rasi -e "   Nothing to search"
      else
        $app 'https://duckduckgo.com/?q='${ans// /+}'&ia=web' &
      fi
    ;;
  $search)
    ans=$($HOME/.config/bspwm/rofi/bin/search.sh)
      if [[ "$ans" == "" ]]; then
        rofi -theme $dir/askpass.rasi -e "   Nothing to search"
      else
        $app $ans &
      fi
    ;;
  $google)
    ans=$($HOME/.config/bspwm/rofi/bin/search.sh)
      if [[ "$ans" == "" ]]; then
        rofi -theme $dir/askpass.rasi -e "   Nothing to search"
      else
        $app 'https://www.google.com/search?q='${ans// /+}'&oq='${ans// /+} &
      fi
    ;;
esac
