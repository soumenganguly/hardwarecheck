#!/bin/bash

#Total Memory
mem = $(cat /proc/meminfo | busybox grep MemTotal | busybox awk '{print $2}')
echo "Total Memory: `busybox expr $mem / 1024` Mb"

#No. of USB's
usb = $(busybox lsusb | lsusb awk '{print $6}' | busybox uniq -c | busybox awk '{print $2}' | busybox wc -l)
echo "No. of USB ports: $usb"

#Wifi mac address
if [ $(busybox ifconfig | busybox grep wlan==" " ]
  then
    echo " Not connected to wifi "
  else
    echo " Wifi mac address: $(busybox ifconfig | busybox grep wlan | busybox awk '{print $5}') "
fi

#Ethernet mac address
if [ $(busybox ifconfig | busybox grep eth | busybox awk '{print $5}')=="" ]
  then
    echo " No Ethernet port detected "
  else
    echo "Ethernet MAC: $(busybox ifconfig | busybox grep eth | busybox awk '{print $5}'"
fi

#Battery capacity
echo "Charge remaining: $(cat /sys/class/power_supply/battery/capacity)%"

#Battery status
echo "Battery Status: $(cat /sys/class/power_supply/battery/status)"

     
 


