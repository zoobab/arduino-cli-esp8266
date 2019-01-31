FROM zoobab/arduino-cli

ENV USER root
COPY blink2.ino /root/Arduino/blink2/blink2.ino
RUN arduino-cli compile --fqbn esp8266:esp8266:nodemcuv2 Arduino/blink2

ENTRYPOINT ["arduino-cli","upload","-p","/dev/ttyUSB0","--fqbn","esp8266:esp8266:nodemcuv2","Arduino/blink2"]
