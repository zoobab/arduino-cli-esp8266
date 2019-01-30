FROM zoobab/arduino-cli
ENV USER root
RUN arduino-cli sketch new blink --debug
COPY blink.ino /root/Arduino/blink/blink.ino
RUN arduino-cli compile --fqbn esp8266:esp8266:nodemcuv2 Arduino/blink
#ENTRYPOINT ["arduino-cli","upload","-p","/dev/ttyUSB0","--fqbn","esp8266:esp8266:nodemcuv2","Arduino/blink"]
