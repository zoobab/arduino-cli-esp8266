[![noswpatv3](http://zoobab.wdfiles.com/local--files/start/noupcv3.jpg)](https://ffii.org/donate-now-to-save-europe-from-software-patents-says-ffii/)
Arduino-cli blink example for ESP2866 + gitlab-ci + kubernetes
==============================================================

The goal here is to blink a LED on an ESP8266 (wemos d1 mini) using:

* arduino-cli
* gitlab-ci
* Raspberry-pi board -> my laptop
* kubernetes -> docker

Standalone arduino-cli
======================

```
$ arduino-cli board listall
$ arduino-cli sketch new blink2
$ cp -v blink2.ino ~/Arduino/blink2/
$ arduino-cli compile --fqbn esp8266:esp8266:d1 Arduino/blink2
$ arduino-cli upload -p /dev/ttyUSB0 --fqbn esp8266:esp8266:d1 Arduino/blink2
```

Gitlab-ci architecture
======================

```
Gitlab -> Gitlab-Runner -> Gitlab-Registry -> SSH-Tunnel -> Laptop -> ESP8266
```

![network diagram](diagram.png)


Expose SSHD to the outside world
================================

```
dockeru@sabayon$ while true; do ssh -R zoobab:18022:localhost:22 serveo.net ; done
```

Docker HTTP API
===============

See https://docs.docker.com/develop/sdk/examples/

K3S on my laptop
================

You can run a simple K3S cluster on your laptop inside docker:

```
$ docker run --privileged -p6443:6443 -d --name k3s ibuildthecloud/k3s:v0.1.0-rc3 server
```

You have to extract the client config located under ```/root/.kube/k3s.yml```.

Note that the ```/dev/ttyUSB0``` device needs to be plugged-in before you start the k3s server.

Screenshot with only docker
============================

Screenshot with only docker, device not attached:

```
$ ./buildandrun.sh
+ docker build -t blink2 .
Sending build context to Docker daemon  461.8kB
Step 1/5 : FROM zoobab/arduino-cli
 ---> de97cab13632
Step 2/5 : ENV USER root
 ---> Using cache
 ---> 76677cdf44e2
Step 3/5 : COPY blink2.ino /root/Arduino/blink2/blink2.ino
 ---> e4af4b1fa471
Step 4/5 : RUN arduino-cli compile --fqbn esp8266:esp8266:d1 Arduino/blink2
 ---> Running in 8dc239621453
Sketch uses 262384 bytes (25%) of program storage space. Maximum is 1044464 bytes.
Global variables use 26792 bytes (32%) of dynamic memory, leaving 55128 bytes for local variables. Maximum is 81920 bytes.
Removing intermediate container 8dc239621453
 ---> d5da4f044b84
Step 5/5 : ENTRYPOINT ["arduino-cli","upload","-p","/dev/ttyUSB0","--fqbn","esp8266:esp8266:d1","Arduino/blink2"]
 ---> Running in b5a82d14655e
Removing intermediate container b5a82d14655e
 ---> 8266d39ef77e
Successfully built 8266d39ef77e
Successfully tagged blink2:latest

real    0m9.830s
user    0m0.030s
sys     0m0.032s
+ docker run --privileged blink2
No new serial port detected.
error: cannot access /dev/ttyUSB0

error: espcomm_open failed
error: espcomm_upload_mem failed
Error: exit status 2
Error during upload.

real    0m11.255s
user    0m0.029s
sys     0m0.023s
```

Problems
========

* docker+ssh feature of 18.09 is badly documented
=======
* could not make ser2net export to another machine working
* docker+ssh of 18.09 release is super badly documented, could not make it work
* docker+ssh instead of k3s/k8s
* gitlab vs github dockerhub support
* Kubernetes Kind containers can see /dev/ttyUSB0
* Try ser2net (exposed on a static URL on k8s)
* Try ser2net TCP port exposure without kubernetes? Unsecure?

Ideas
=====

* file a bug about the bad caching (needed to do a first blink.ino to fully cache the sdk)
* file a bug with an alpine container (could not run the static binary in there, g++ issue)
* try USB over IP transport to transport the /dev/ttyUSB0 http://usbip.sourceforge.net/
* document docker usage
* make as many docker images as there are targets
* fix the ser2net forwarding and make a simple docker listener
* (from a fosdem question) add support for a virtual target QEMU+AVR https://github.com/michaelrolnik/qemu-avr
* (from a fosdem question) add support for a virtual target SimAV https://github.com/buserror/simavr
* (from a fosdem question) add a simple test example (grepping the serial console for a git version banner for ex, ```cat /dev/ttyUSB0 | grep HIGH``` seems to do the job)
* WebIDE with webusb direct communication to the USB device? Like the Dapboot project https://github.com/devanlai/dapboot
* Arduino-IDE git support
* docker run with your ino code as argument
* replace the Raspbery with a second esp with Jeelink firmware to bridge the serial port to a box in the cloud: http://www.zoobab.com/esp8266-serial2wifi-bridge
* standard k8s on rpi
* compile for both arches at the same time (laptop in amd64, rpi in armv7)
* qemu-arm-static wrapper so that the tools are in armv7

Links
=====

* Fosdem 2019 talk: https://fosdem.org/2019/schedule/event/hw_gitlab_ci_arduino/
* Fosdem 2019 video recording: https://www.youtube.com/watch?v=-oBBWSjnOVU
* Arduino CLI: https://github.com/arduino/arduino-cli
* K3S Kubernetes stripped: https://github.com/ibuildthecloud/k3s
