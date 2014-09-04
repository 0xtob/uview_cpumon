#!/bin/bash

# Computes the CPU usage based on /proc/stat and sends it to the Arduino over serial.

lasttotal=0
lastidle=0

while true; do
    tokens=(`head -n 1 /proc/stat`)
    total=$((tokens[1]+tokens[2]+tokens[3]+tokens[4]+tokens[5]+tokens[6]+tokens[7]))
    idle=${tokens[4]}

    curtotal=$((total-lasttotal))
    curidle=$((idle-lastidle))

    echo "scale=20; 100*(1-$curidle/$curtotal)" | bc | cut -d '.' -f 1 > /dev/ttyUSB0
    sleep 0.2

    lasttotal=$total
    lastidle=$idle
done
