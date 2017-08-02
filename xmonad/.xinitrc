#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

export XMODIFIERS=@im=SCIM
export GTK_IM_MODULE="scim"
export QT_IM_MODULE="scim"
export STEAM_FRAME_FORCE_CLOSE=1
export _JAVA_AWT_WM_NONREPARENTING=1


xbindkeys
xmodmap ~/.Xmodmap
xrdb ~/.Xresources
setxkbmap -option compose:ralt
xsetroot -cursor_name left_ptr
~/.screenlayout/default.sh


/usr/lib/systemd/systemd --user &
wallpaper &
#redshift -l 51:-114 -r &
/usr/bin/xscreensaver -no-splash &
scim -d
synergys

exec $1
