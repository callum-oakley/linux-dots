#!/bin/sh

xrdb $HOME/.Xresources
if (xrandr | rg 'HDMI-2 connected'); then
  xrdb -override .Xresources-96dpi
  mons -s
  xset s off && xset dpms 10800 10800 10800
  export WINDOW_SCALING='1'
else
  xrdb -override .Xresources-144dpi
  export WINDOW_SCALING='1.5'
fi

x=$(xrandr | rg '\*' | cut -d ' ' -f 4 | cut -d x -f 1)
y=$(xrandr | rg '\*' | cut -d ' ' -f 4 | cut -d x -f 2)
export BORDER=5
export PAD=20
export GAP=$((2 * BORDER + PAD))
export UNIT_X=$(((x - PAD) / 12))
export UNIT_Y=$(((y - PAD) / 12))
export 2_UNIT_X=$((2 * UNIT_X))
export 2_UNIT_Y=$((2 * UNIT_Y))

export WINDOW_WIDTH_1=$((($x - 20 * 4 - 10 * 3) / 3))
export WINDOW_WIDTH_2=$((($x - 20 * 3 - 10 * 2) / 2))
export WINDOW_WIDTH_3=$(($WINDOW_WIDTH_1 * 2 + 20 + 10))
export WINDOW_HEIGHT_1=$((($y - 20 * 4 - 10 * 3) / 3))
export WINDOW_HEIGHT_2=$((($y - 20 * 3 - 10 * 2) / 2))
export WINDOW_HEIGHT_3=$(($WINDOW_HEIGHT_1 * 2 + 20 + 10))
export WINDOW_HEIGHT_FULL=$(($y - 20 * 2 - 10 * 1))
export X_HOP_1=$((($WINDOW_WIDTH_1 + 20 + 10) / 2))
export Y_HOP_1=$((($WINDOW_HEIGHT_1 + 20 + 10) / 2))
export X_HOP_2=$((($WINDOW_WIDTH_2 + 20 + 10) / 4))
export Y_HOP_2=$((($WINDOW_HEIGHT_2 + 20 + 10) / 4))

if (aplay -L | rg 'CARD=Audio'); then
  export ALSA_CARD=Audio
else
  export ALSA_CARD=PCH
fi

$HOME/bin/configure-inputs &
xsetroot -solid '#1B2B34' &
xsetroot -cursor_name left_ptr &
eval $(ssh-agent)
sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
exec windowchef
