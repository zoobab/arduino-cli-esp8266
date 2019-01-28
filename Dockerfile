FROM zoobab/arduino-cli
WORKDIR /root
ENV USER root
COPY dot-cli-config.yml /go/bin/.cli-config.yml
RUN arduino-cli core update-index --debug
RUN arduino-cli core install esp8266:esp8266
RUN arduino-cli board listall
RUN arduino-cli sketch new blink --debug
COPY blink.ino /root/Arduino/blink/blink.ino
RUN arduino-cli compile --fqbn esp8266:esp8266:nodemcuv2 Arduino/blink
ENTRYPOINT ["arduino-cli","upload","-p","/dev/ttyUSB0","--fqbn","esp8266:esp8266:nodemcuv2","Arduino/blink"]
