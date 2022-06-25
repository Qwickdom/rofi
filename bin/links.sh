#!/usr/bin/env bash

dirb="$HOME/.config/bspwm/rofi/bin"
dirt="$HOME/.config/bspwm/rofi/themes"
rofi_command="rofi -theme $dirt/links.rasi"

# Browser
app="chromium --incognito"

# Links
arch=""
github=""
search=""
mail=""
youtube=""

# Internet is ok?
STATUS="$(nmcli radio wifi)"

if (ping -c 1 archlinux.org || ping -c 1 google.com || ping -c 1 github.com || ping -c 1 sourceforge.net) \
    &>/dev/null; then
  if [[ $STATUS == *"enable"* ]]; then
    # Variable passed to rofi
    options="$arch\n$github\n$search\n$mail\n$youtube"

    chosen="$(echo -e "$options" | $rofi_command -p "Quicklinks | Chromium Incognito" -dmenu -selected-row 2)"
    case $chosen in
      $arch)
        $app 'https://www.archlinux.org' &
        ;;
      $github)
        $dirb/git.sh
        ;;
      $search)
        $dirb/duckgoo.sh
        ;;
      $mail)
        $app 'https://www.gmail.com' &
        ;;
      $youtube)
        $dirb/yt.sh
        ;;
    esac
  fi
else
  rofi -theme $dirt/askpass.rasi -e "     Disconnected"
fi
