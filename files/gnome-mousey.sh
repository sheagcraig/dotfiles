#!/bin/bash

#MOUSE_ID=$(xinput --list | grep "Taco's Mouse" | awk 'id=\d\+' {
MOUSE_ID="DonkeyPointer"
xinput --set-prop "$MOUSE_ID" "Device Accel Constant Deceleration" 1.5
xinput --set-prop "$MOUSE_ID" "Device Accel Velocity Scaling" 0.9
xinput set-button-map "$MOUSE_ID" 1 2 3 5 4