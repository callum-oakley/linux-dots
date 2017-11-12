#!/bin/sh

xrdb $HOME/.Xresources
if (xrandr | rg -q 'HDMI-?. connected'); then
  xrdb -override .Xresources-96dpi
  mons -s
  export GRID_SIZE=24
  export WINDOW_SCALING='1'
else
  xrdb -override .Xresources-144dpi
  export GRID_SIZE=16
  export WINDOW_SCALING='1.5'
fi
xset s off && xset dpms 10800 10800 10800

export SCREEN_W=$(wattr w $(lsw -r))
export SCREEN_H=$(wattr h $(lsw -r))
export BORDER=5
export PAD=20
export GAP=$((2 * BORDER + PAD))
export UNIT_X=$(((SCREEN_W - PAD) / GRID_SIZE))
export UNIT_Y=$(((SCREEN_H - PAD) / GRID_SIZE))

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx

if (aplay -L | rg -q 'CARD=Audio'); then
  export ALSA_CARD=Audio
else
  export ALSA_CARD=PCH
fi

$HOME/bin/configure-inputs
xsetroot -solid '#1B2B34'
xsetroot -cursor_name left_ptr
eval $(ssh-agent)

unclutter &
sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
exec windowchef
