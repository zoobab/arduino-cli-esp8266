Arduino-cli blink example for ESP2866 + gitlab-ci + kubernetes
==============================================================

The goal here is to blink a LED on an ESP8266 (wemos d1 mini) using:

* gitlab-ci
* docker
* Raspberry-pi board
* kubernetes with its k3s fork

Ideas
=====

* gitlab vs github dockerhub support
* multistage build:
** arduino-cli
** arduino-cli+esp8266
** arduino-cli+esp8266+yourcode
* docker run with your ino code as argument
* docker+ssh instead of k3s/k8s
* standard k8s on rpi
* /var/lib/docker on usb stick?
* 32gb microsd
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
