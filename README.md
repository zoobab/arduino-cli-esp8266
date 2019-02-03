Arduino-cli blink example for ESP2866 + gitlab-ci + kubernetes
==============================================================

The goal here is to blink a LED on an ESP8266 (wemos d1 mini) using:

* gitlab-ci
* docker
* Raspberry-pi board
* kubernetes: k3s, minikube --vm-driver=none, kind

Standalone arduino-cli
======================

```
$ arduino-cli board listall
$ arduino-cli sketch new blink2
$ cp -v blink2.ino ~/Arduino/blink2/
$ arduino-cli compile --fqbn esp8266:esp8266:d1 Arduino/blink2
$ arduino-cli upload -p /dev/ttyUSB0 --fqbn esp8266:esp8266:d1 Arduino/blink2
```

Expose SSHD to the outside world
================================

```
dockeru@sabayon$ while true; do ssh -R zoobab:18022:localhost:22 serveo.net ; done
```

Problems and ideas
==================

* gitlab vs github dockerhub support
* multistage build:
** arduino-cli
** arduino-cli+esp8266
** arduino-cli+esp8266+yourcode
* docker run with your ino code as argument
* docker+ssh instead of k3s/k8s
* standard k8s on rpi
* qemu-arm-static wrapper so that the tools are in armv7
* compile for both arches at the same time (laptop in amd64, rpi in armv7)
* Tried "minikube --vm-driver=none start", failed on my laptop, unstable
* K3s evicts pods and crash (maybe disk is under pressure?)
* replace the Raspbery with a second esp with Jeelink firmware to bridge the serial port to a box in the cloud: http://www.zoobab.com/esp8266-serial2wifi-bridge

* Try ser2net (exposed on a static URL on k8s)
* Try ser2net TCP port exposure without kubernetes? Unsecure?

* WebIDE with webusb direct communication to the USB device? Like the Dapboot project https://github.com/devanlai/dapboot

Links
=====

* Fosdem 2019 talk: https://fosdem.org/2019/schedule/event/hw_gitlab_ci_arduino/
* Arduino CLI: https://github.com/arduino/arduino-cli
* K3S Kubernetes stripped: https://github.com/ibuildthecloud/k3s
