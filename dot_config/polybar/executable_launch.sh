#!/usr/bin/env bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

echo "---" | tee -a /tmp/polybar.log
polybar bitbar 2>&1 | tee -a /tmp/polybar.log & disown
