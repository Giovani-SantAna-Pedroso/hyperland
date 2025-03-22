#!/bin/bash

while true; do
    monitor_id=0  # Change this to the desired monitor index
    hyprctl dispatch movecursortomonitor $monitor_id
    sleep 0.1  # Adjust if needed
done
