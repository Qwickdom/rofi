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
    $app 'https://duckduckgo.com/?q='${ans// /+}'&ia=web' &
    ;;
  $search)
    ans=$($HOME/.config/bspwm/rofi/bin/search.sh)
    $app $ans &
    ;;
  $google)
    ans=$($HOME/.config/bspwm/rofi/bin/search.sh)
    $app 'https://www.google.com/search?q='${ans// /+}'&oq='${ans// /+} &
    ;;
esac
