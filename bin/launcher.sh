#!/usr/bin/env bash

rofi \
    -show drun \
    -modi run,drun,ssh \
    -disable-history \
    -no-lazy-grab \
    -scroll-method 0 \
    -drun-match-fields all \
    -drun-display-format "{name}" \
    -no-drun-show-actions \
    -terminal alacritty \
    -kb-cancel Escape \
    -theme ~/.config/bspwm/rofi/themes/launcher.rasi