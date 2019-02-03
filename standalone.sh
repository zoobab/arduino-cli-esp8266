#!/bin/bash
set -x
arduino-cli board listall
arduino-cli sketch new blink2
cp -v blink2.ino ~/Arduino/blink2/
arduino-cli compile --fqbn esp8266:esp8266:d1 Arduino/blink2
arduino-cli upload -p /dev/ttyUSB0 --fqbn esp8266:esp8266:d1 Arduino/blink2
