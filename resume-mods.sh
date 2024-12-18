#!/bin/bash

echo "resume-mods running..."

# record current state
STATE=$(cat /tmp/.deckyplumber.state)

sudo systemctl restart inputplumber

sleep 2

busctl call org.shadowblip.InputPlumber /org/shadowblip/InputPlumber/CompositeDevice0 org.shadowblip.Input.CompositeDevice SetTargetDevices "as" 3 "$STATE" keyboard mouse

echo "resume-mods complete"