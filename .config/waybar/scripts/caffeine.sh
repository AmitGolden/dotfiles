#!/bin/sh

if pgrep -x sleep.sh > /dev/null; then
  echo '{ "percentage": 0 }'
else
  echo '{ "percentage": 100 }'
fi
