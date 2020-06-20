#!/bin/bash

if [[ $(pgrep -c redshift) = 0 ]]; then
    echo "redshift not running"
    START=1
else
    echo "redshift already running"
    START=0
fi

xrandr --verbose -q | grep Gamma | grep -q "1.0:1.0:1.0";
#if [[ "$*" = "on" ]]; then
if [ $? == 0 ]; then
  echo Making screen red
  if [[ $START = 0 ]]; then
      notify-send "stopping redshift"
      pkill -STOP redshift
      sleep .2
  fi
  redshift -rPO1500
#elif [[ "$*" = "off" ]]; then
else
    redshift -x
    if [[ $START = 0 ]]; then
        echo "cont red"
        notify-send "continuing redshift"
        pkill -CONT redshift
    else
        echo "start red"
        notify-send "starting redshift"
        redshift &
    fi
#else
#  echo "requires one of: 'on', 'off'"
#  exit 1
fi
