#!/usr/bin/env bash

# You can call this script like this:
# $ ./volumeControl.sh up
# $ ./volumeControl.sh down
# $ ./volumeControl.sh mute

# Script modified from these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

NotificationID_File=/tmp/volume_notification_id

function get_volume {
  amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
  amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function get_notification_id {
  if [ -s "$NotificationID_File" ]; then
    cat $NotificationID_File
  else
    echo 0
  fi
}

function send_notification {
  iconSound="audio-volume-high"
  iconMuted="audio-volume-muted"
  nid=$(get_notification_id)
  if is_mute ; then
    notify-send -i $iconMuted -p -r $nid -u normal "Muted" > $NotificationID_File
  else
    volume=$(get_volume)
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq --separator="─" 0 "$(((volume - 1) / 4))" | sed 's/[0-9]//g')
    space=$(seq --separator=" " 0 "$(((100 - volume) / 4))" | sed 's/[0-9]//g')
    # Send the notification
    notify-send -i $iconSound -p -r $nid -u normal "|$bar$space| $volume%" > $NotificationID_File
  fi
}

case $1 in
  up)
    # set the volume on (if it was muted)
    amixer -D pipewire set Master on > /dev/null
    # up the volume (+ 5%)
    amixer -D pipewire sset Master 5%+ > /dev/null
    send_notification
    canberra-gtk-play -i audio-volume-change -d "changeVolume"
    ;;
  down)
    amixer -D pipewire set Master on > /dev/null
    amixer -D pipewire sset Master 5%- > /dev/null
    send_notification
    canberra-gtk-play -i audio-volume-change -d "changeVolume"
    ;;
  mute)
    # toggle mute
    amixer -D pipewire set Master 1+ toggle > /dev/null
    send_notification
    ;;
esac
