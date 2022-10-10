#!/bin/sh

if pgrep -x sleep.sh > /dev/null; then
	dunstify -r 4444 -i /usr/share/icons/Papirus-Dark/symbolic/status/my-caffeine-on-symbolic.svg "Caffeine Enabled"
    kill -9 $(pgrep swayidle | tail -1)
else
	dunstify -r 4444 -i /usr/share/icons/Papirus-Dark/symbolic/status/my-caffeine-off-symbolic.svg "Caffeine Disabled"
    ~/.config/hypr/scripts/sleep.sh &
fi
