#!/bin/sh

xrdb $HOME/.Xresources
if (xrandr | rg 'HDMI-2 connected'); then
  xrdb -override .Xresources-96dpi
  mons -s
  xset s off && xset dpms 10800 10800 10800
  grid_size=24
  export WINDOW_SCALING='1'
else
  xrdb -override .Xresources-144dpi
  grid_size=16
  export WINDOW_SCALING='1.5'
fi

x=$(xrandr | rg '\*' | cut -d ' ' -f 4 | cut -d x -f 1)
y=$(xrandr | rg '\*' | cut -d ' ' -f 4 | cut -d x -f 2)
export BORDER=5
export PAD=20
export GAP=$((2 * BORDER + PAD))
export UNIT_X=$(((x - PAD) / grid_size))
export UNIT_Y=$(((y - PAD) / grid_size))

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
