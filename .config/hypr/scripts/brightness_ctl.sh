#!/usr/bin/env bash

# You can call this script like this:
# $ ./brightnessControl.sh up
# $ ./brightnessControl.sh down

# Script inspired by these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a


function get_brightness {
	brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}'
}

function send_notification {
  icon="preferences-system-brightness-lock"
  brightness=$(get_brightness)
  # Make the bar with the special character ─ (it's not dash -)
  # https://en.wikipedia.org/wiki/Box-drawing_character
  bar=$(seq -s "─" 0 $(((brightness - 1) / 4)) | sed 's/[0-9]//g')
  space=$(seq --separator=" " 0 "$(((100 - brightness) / 4))" | sed 's/[0-9]//g')
  # Send the notification
  dunstify -i "$icon" -r 5555 -u normal "|$bar$space| $brightness%"
}


case $1 in
  up)
    # increase the backlight by 5%
    brightnessctl set 5%+
    send_notification
    ;;
  down)
    # decrease the backlight by 5%
    brightnessctl set 5%-
    send_notification
    ;;
  max)
    brightnessctl set 100%
    send_notification
    ;;
  blank)
    brightnessctl set 0%
    send_notification
    ;;
esac
