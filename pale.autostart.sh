#!/usr/bin/env bash

function run {
  if ! pgrep $1;
  then
    $@&
  fi
}

run ibus-daemon -drxR

run slack
run nextcloud

xmodmap ~/.Xmodmap
