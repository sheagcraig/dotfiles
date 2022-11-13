#!/bin/zsh
while (( `osascript -e "input volume of (get volume settings)"` < 100 )); do
    osascript -e "set volume input volume (input volume of (get volume settings) + 3)";
    sleep 0.1;
done;

