#!/bin/sh

if pgrep -x sleep.sh > /dev/null; then
	dunstify -r 4444 -i /usr/share/icons/Papirus-Dark/symbolic/status/my-caffeine-on-symbolic.svg "Caffeine Enabled"
    killall swayidle
    ~/.config/hypr/scripts/lock_on_sleep.sh &
else
	dunstify -r 4444 -i /usr/share/icons/Papirus-Dark/symbolic/status/my-caffeine-off-symbolic.svg "Caffeine Disabled"
    killall swayidle
    ~/.config/hypr/scripts/sleep.sh &
fi
