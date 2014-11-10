#!/bin/bash

#Script to check the hardware specs.

#No. of CPU's
echo "No. of CPU's:" $(nproc)""

#Installed RAM
vari=$(cat /proc/meminfo | grep MemTotal | awk '{print $2}')
echo "Total Memory: $vari kB"

#No. of USB ports
echo "No. of USB ports: $(lsusb | wc -l)"

#MAC address of Ethernet and wifi
#Ethernet
emac=$(ifconfig | grep eth0 | awk '{print $5}')
echo "Ethernet mac address: $emac"

#wifi mac address
if [ $(ifconfig | grep wlan)=="" ]
then
  :
else
  wlanmac=$(ifconfig | grep wlan | awk '{print $5}')
  echo "wifi mac address: $wlanmac"
fi

#Check the status of the battery
#NOTE: Uncomment the 4 lines below if running this script on an laptop.
#capacity="$(cat /sys/class/power_supply/BAT0/capacity)"
#echo "Charge remaining: $(capacity)%"
#status="$(cat /sys/class/power_supply/BAT0/status)"
#echo "Status of battery: $(status)"

#Check the screen resolution
scr=$(xdpyinfo | awk '/dimensions:/ {print $2}')
echo "Screen resolution: $scr" 














