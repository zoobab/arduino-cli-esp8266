Arduino-cli blink example for ESP2866 + gitlab-ci + kubernetes
==============================================================

The goal here is to blink a LED on an ESP8266 (wemos d1 mini) using:

* gitlab-ci
* docker
* Raspberry-pi board
* kubernetes with its k3s fork

Problems
========

* Tried "minikube --vm-driver=none start", failed on my laptop, unstable
* K3s evicts pods and crash (maybe disk is under pressure?)
* Try ser2net (exposed on a static URL on k8s)
* Try ser2net TCP port exposure without kubernetes? Unsecure?
* WebIDE with webusb direct communication to the USB device? Like the Dapboot project https://github.com/devanlai/dapboot

Links
=====

* Fosdem 2019 talk: https://fosdem.org/2019/schedule/event/hw_gitlab_ci_arduino/
* Arduino CLI: https://github.com/arduino/arduino-cli
* K3S Kubernetes stripped: https://github.com/ibuildthecloud/k3s