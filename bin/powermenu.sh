#!/usr/bin/env bash

dir="$HOME/.config/bspwm"
rofi_command="rofi -theme $dir/rofi/themes/powermenu.rasi"
uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"
_msg=" Options - yes/y/no/n"

chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 2)"
case $chosen in
  $shutdown)
    ans=$($HOME/.config/bspwm/rofi/bin/confirm.sh)
    if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
      systemctl poweroff
    elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
      exit
    else
      rofi -theme ~/.config/bspwm/rofi/themes/askpass.rasi -e "$_msg"
    fi
    ;;
  $reboot)
    ans=$($HOME/.config/bspwm/rofi/bin/confirm.sh)
    if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
      systemctl reboot
    elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
      exit
    else
      rofi -theme ~/.config/bspwm/rofi/themes/askpass.rasi -e "$_msg"
    fi
    ;;
  $lock)
    betterlockscreen -l --off 5
    ;;
  $suspend)
    ans=$($HOME/.config/bspwm/rofi/bin/confirm.sh)
    if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
      betterlockscreen --suspend
    elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
      exit
    else
      rofi -theme ~/.config/bspwm/rofi/themes/askpass.rasi -e "$_msg"
    fi
    ;;
  $logout)
    ans=$($HOME/.config/bspwm/rofi/bin/confirm.sh)
    if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
      kill -9 -1
    elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
      exit
    else
      rofi -theme ~/.config/bspwm/rofi/themes/askpass.rasi -e "$_msg"
    fi
    ;;
esac
