#!/usr/bin/env bash

dir="$HOME/.config/bspwm"
rofi_command="rofi -theme $dir/rofi/themes/network.rasi"
rasi_dir="$dir/rofi/themes/share.rasi"

# Icons
launch_cli=""
share_pass="練"

# Get info
IFACE="$(nmcli | grep -i interface | awk '/interface/ {print $2}' | sed -n 1p)"
STATUS="$(nmcli radio wifi)"

active=""
urgent=""

if (ping -c 1 archlinux.org || ping -c 1 google.com || ping -c 1 github.com || ping -c 1 sourceforge.net) \
  &>/dev/null; then
  if [[ $STATUS == *"enable"* ]]; then
    if [[ $IFACE == e* ]]; then
      connected=""
    else
      connected=""
    fi
  active="-a 0"
  SSID="$(nmcli -t -f name,device connection show --active | grep wlp1s0 | cut -d\: -f1)"
  options="$connected\n$launch_cli\n$share_pass"
  sed -i "16s/181px;/256px;/" "$dir/rofi/themes/network.rasi"
  fi
else
  urgent="-u 0"
  SSID="Disconnected"
  connected=""
  options="$connected\n$launch_cli"
  sed -i "16s/256px;/181px;/" "$dir/rofi/themes/network.rasi"
fi

# Share pass
share_pass() {
  ssid=$(nmcli dev wifi show-password | grep -e SSID:)
  pass=$(nmcli dev wifi show-password | grep -e Password:)
  ip4="IP: $(nmcli -t -f IP4.ADDRESS dev show ${WIRELESS_INTERFACES[$i]} | grep 192 | awk -F '[:/]' '{print $2}')"
  iface="Interface: $IFACE"
  options="$ssid\n$pass\nQrCode\n$ip4\n$iface"
  SELECTION=$(echo -e "$options" | rofi -dmenu -a "2" -theme "$rasi_dir")
  case "$SELECTION" in
    $ssid)
      echo "$ssid" | cut -d ' ' -f 2 | clipster -c
      ;;
    $pass)
      echo "$pass" | cut -d ' ' -f 2 | clipster -c
      ;;
    "QrCode")
      gen_qrcode
      ;;
    $ip4)
      echo "$ip4" | cut -d ' ' -f 2 | clipster -c
      ;;
    $iface)
      echo "$ip4" | cut -d ' ' -f 2 | clipster -c
      ;;
  esac
}

gen_qrcode() {
  QR="$(qrencode -t png -o /tmp/wifi_qr.png -s 10 -m 2 "WIFI:S:""$( nmcli dev wifi show-password \
    | grep -oP '(?<=SSID: ).*' | head -1)"";T:""$(nmcli dev wifi show-password \
    | grep -oP '(?<=Security: ).*' | head -1)"";P:""$(nmcli dev wifi show-password \
    | grep -oP '(?<=Password: ).*' | head -1)"";;")"
  $QR
  feh /tmp/wifi_qr.png
}

# Main
chosen="$(echo -e "$options" | $rofi_command -p "$SSID" -dmenu $active $urgent -selected-row 1)"
case $chosen in
  $connected)
    if [[ $STATUS == *"enable"* ]]; then
      nmcli radio wifi off
    else
      nmcli radio wifi on
    fi 
    ;;
  $launch_cli)
    alacritty --class 'alacritty-float,alacritty-float' -e nmtui
    ;;
  $share_pass)
    share_pass
    ;;
esac
