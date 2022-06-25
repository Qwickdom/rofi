#!/usr/bin/env bash

dir="$HOME/.config/bspwm/rofi"
rofi_command="rofi -theme $dir/themes/screenshot.rasi"
time=`date +%Y-%m-%d-%S`
geometry=`xrandr | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current'`
shot="$HOME/Pictures"
file="Screenshot_${time}_${geometry}.png"

# Error msg
msg() {
    rofi -theme "$dir/themes/message.rasi" -e "Please install 'scrot' first"
}

# notify and view screenshot
notify_view () {
  dunstify -u low --replace=699 "Copied to clipboard"
  viewnior ${shot}/"$file"
  if [[ -e "$shot/$file" ]]; then
    dunstify -u low --replace=699 "Screenshot saved"
  else
    dunstify -u low --replace=699 "Screenshot deleted"
  fi
}

# countdown
countdown () {
  for sec in `seq $1 -1 1`; do
    dunstify -t 1000 --replace=699 "Shot in: $sec"
    sleep 1
  done
}

# Options
screen=""
area=""
window=""
time="祥"

# Variable passed to rofi
options="$screen\n$area\n$window\n$time"

chosen="$(echo -e "$options" | $rofi_command -p 'Take good screenshots with scrot' -dmenu -selected-row 0)"
case $chosen in
  $screen)
    if [[ -f /usr/bin/scrot ]]; then
      scrot "$file"
      mv *.png "$shot"
      cd "$shot" | xclip -selection clipboard "$file"
      notify_view
    else
      msg
    fi
    ;;
  $area)
    if [[ -f /usr/bin/scrot ]]; then
      scrot -s "$file"
      mv *.png $shot
      cd "$shot" | xclip -selection clipboard "$file"
      notify_view
    else
      msg
    fi
    ;;
  $window)
    if [[ -f /usr/bin/scrot ]]; then
      scrot -u "$file"
      mv *.png $shot
      cd "$shot" | xclip -selection clipboard "$file"
      notify_view
    else
      msg
    fi
    ;;
  $time)
    ans=$($HOME/.config/bspwm/rofi/bin/secons.sh)
    if [[ $ans > 0 ]] || [[ -f /usr/bin/scrot ]]; then
      countdown "$ans"
      scrot "$file"
      mv *.png $shot
      cd "$shot" | xclip -selection clipboard "$file"
      notify_view
    else
      msg
    fi
    ;;
esac
