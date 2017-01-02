#!/bin/bash


mkdir -p /usr/share/sane/gt68xx/
cp PS1Dfw.usb /usr/share/sane/gt68xx/
cp PS1Gfw.usb /usr/share/sane/gt68xx/

chmod a+r /usr/share/sane/gt68xx/PS1Dfw.usb
chmod a+r /usr/share/sane/gt68xx/PS1Gfw.usb
