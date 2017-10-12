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

if (xinput list | rg 'OLKB'); then
  xinput disable 'Apple Inc. Apple Internal Keyboard / Trackpad'
fi
xset r rate 200 30

if (xinput list | rg 'CST'); then
  trackball_id=$(xinput list | rg 'CST' | cut -f 2 | cut -d= -f 2)
  xinput set-prop $trackball_id 283 0, 1
  xinput set-prop $trackball_id 280 -0.7
  xinput set-prop $trackball_id 276 1
fi

if (xinput list | rg 'bcm5974'); then
  trackpad_id=$(xinput list | rg 'bcm5974' | cut -f 2 | cut -d= -f 2)
  xinput set-prop $trackpad_id 294 1
  xinput set-prop $trackpad_id 276 1
fi

if (aplay -L | rg 'CARD=AUDIO'); then
  export ALSA_CARD=Audio
else
  export ALSA_CARD=PCH
fi

x=$(xrandr | rg '\*' | cut -d ' ' -f 4 | cut -d x -f 1)
y=$(xrandr | rg '\*' | cut -d ' ' -f 4 | cut -d x -f 2)
export WINDOW_WIDTH_1=$((($x - 20 * 4 - 10 * 3) / 3))
export WINDOW_WIDTH_2=$((($x - 20 * 3 - 10 * 2) / 2))
export WINDOW_WIDTH_3=$(($WINDOW_WIDTH_1 * 2 + 20 + 10))
export WINDOW_HEIGHT_FULL=$(($y - 20 * 2 - 10 * 1))
export WINDOW_HEIGHT_HALF=$((($y - 20 * 3 - 10 * 2) / 2))

xsetroot -solid '#65737e' &
xsetroot -cursor_name left_ptr &
eval $(ssh-agent)
sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
exec windowchef
