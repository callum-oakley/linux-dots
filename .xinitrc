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
export WINDOW_WIDTH_1=$((($x - 20 * 4 - 10 * 3) / 3))
export WINDOW_WIDTH_2=$((($x - 20 * 3 - 10 * 2) / 2))
export WINDOW_WIDTH_3=$(($WINDOW_WIDTH_1 * 2 + 20 + 10))
export WINDOW_HEIGHT_FULL=$(($y - 20 * 2 - 10 * 1))
export WINDOW_HEIGHT_TWO_THIRDS=$((2 * ($y - 20 * 3 - 10 * 2) / 3))
export WINDOW_HEIGHT_HALF=$((($y - 20 * 3 - 10 * 2) / 2))

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
