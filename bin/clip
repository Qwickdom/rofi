#!/bin/sh

dir="$HOME/.config/bspwm"
rofi_command="rofi -theme $dir/rofi/themes/clip.rasi"

# Extract clipboard history from clipster and format for rofi
C_HIST="$(clipster -c -o -n 7 -0 \
        | gawk 'BEGIN {RS = "\0"; ORS = "\0"} NF > 0 { print substr($0, 1, 250) }' \
        | gawk 'BEGIN {RS = "\0"; FS="\n"; OFS=" " } { $1=$1; print $0 }'  \
        | sed 's/^ *//' \
        | gawk '{printf("%3d %s\n", NR, $0)}')"

# Echo clipboard items to Rofi and save the selection made by user
SELECTION="$(echo "$C_HIST" | $rofi_command -dmenu -p 'Clipboard history selection')"

# Verify user made a selection
if [ -n "$SELECTION" ]; then

  # Retrieve the line number from the beginning of selection and remove leading zeros
  NUMBER="$(echo "$SELECTION" | cut -c1-3 | sed 's/^0*//')"

  # Extract clipboard history from clipster and find the nth non-empty clip based selected line number
  EXACT_SELECTION="$(clipster -c -o -n 7 -0 \
                   | gawk 'BEGIN {RS = "\0"; ORS = "\0"} NF > 0 { print }' \
                   | gawk 'BEGIN {RS = "\0"}'"NR == $NUMBER { print; exit }")"

  # Echo the selection back to clipster
  echo -n "$EXACT_SELECTION" | clipster -c
fi
