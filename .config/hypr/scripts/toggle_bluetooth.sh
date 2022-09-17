#!/bin/sh

state=$(bluetoothctl -- show | grep Powered | awk '{ print $2 }')

if [[ $state == 'yes' ]]; then
    bluetoothctl -- power off
else
    bluetoothctl -- power on
fi
