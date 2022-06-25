#!/usr/bin/env bash

DIR="$HOME"
DIRA="$HOME/.config/alacritty"
DIRB="$HOME/.config/bspwm"
DIRD="$HOME/.config/bspwm/dunst"
DIRP="$HOME/.config/bspwm/polybar"
DIRR="$HOME/.config/bspwm/rofi/themes"
DIRG="$HOME/.config/gtk-3.0"

change_alacritty() {
  cat "$DIRA"/colors/$trm.yml > "$DIRA"/colors.yml
}

change_bar() {
  cat "$DIRP"/$bar/config.ini > "$DIRP"/config.ini
  polybar-msg cmd restart
}

change_dunst() {
  cat "$DIRD"/colors/dunstrc-$bar > "$DIRD"/dunstrc
}

change_feh() {
  feh --bg-scale "$DIRB"/wallpapers/"$bg"
}

change_gtk() {
  sed -i "5s/=.*/=$gtk2/" "$DIR"/.gtkrc-2.0
  sed -i "6s/=.*/=$gtk2_icon/" "$DIR"/.gtkrc-2.0
  sed -i "8s/=.*/=$gtk2_icon_c/" "$DIR"/.gtkrc-2.0
  sed -i "2s/=.*/=$gtk3/" "$DIRG"/settings.ini
  sed -i "3s/=.*/=$gtk3_icon/" "$DIRG"/settings.ini
  sed -i "5s/=.*/=$gtk3_icon_c/" "$DIRG"/settings.ini
}

change_rofi() {
  cat "$DIRR"/colors/colors-$bar.rasi > "$DIRR"/colors.rasi
}

change_vim() {
  sed -i "109s/.*/colorscheme $trm/" "$DIR"/.vimrc
}

if  [[ "$1" = "--ganyu" ]]; then
  trm="tokyonight"
  bar="ganyu"
  bg="Ganyu.png"
  gtk2='"Tokyo-Darker"'
  gtk2_icon='"Tela-circle-black-dark"'
  gtk2_icon_c='"Simp1e-Tokyo-Night"'
  gtk3='Tokyo-Darker'
  gtk3_icon='Tela-circle-black-dark'
  gtk3_icon_c='Simp1e-Tokyo-Night'
  change_alacritty
  change_bar
  change_dunst
  change_feh
  change_gtk
  change_rofi
  change_vim
  sleep 2; bspc wm -r

elif  [[ "$1" = "--hsgrl" ]]; then
  trm="dracula"
  bar="hsgrl"
  bg="HSG.jpg"
  gtk2='"Dracula"'
  gtk2_icon='"Tela-circle-dracula-dark"'
  gtk2_icon_c='"Simp1e-Catppuccin"'
  gtk3='Dracula'
  gtk3_icon='Tela-circle-dracula-dark'
  gtk3_icon_c='Simp1e-Catppuccin'
  change_alacritty
  change_bar
  change_dunst
  change_feh
  change_gtk
  change_rofi
  change_vim
  sleep 2; bspc wm -r

else
  echo "No option specified, Available options: --ganyu   --hsgrl"
fi
