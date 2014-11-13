#!/bin/bash

#Script to check the hardware specs.

#Serial no.
sno=$(zenity --entry --text='Please enter the Serial no. of the netbook.") 

#No. of CPU's
echo "No. of CPU's:$(nproc)"

#Installed RAM
vari=$(cat /proc/meminfo | grep MemTotal | awk '{print $2}')
echo "Total Memory: $vari kB"

#No. of USB ports
i=0
for id in $(lsusb | awk '{print $6}')
do
  usb_id[$i]=$id
  i=`expr $i + 1`
done
#echo ${usb_id[*]}

                     #OR

usb=$(lsusb | awk '{print $6}' | uniq -c | awk '{print $2}' | wc -l)
echo "No. of USB ports: $usb"
               
#MAC address of Ethernet and wifi
#Ethernet
emac=$(ifconfig | grep eth0 | awk '{print $5}')
echo "Ethernet mac address: $emac"

#wifi mac address
if [ $(ifconfig | grep wlan)=="" ]
then
  wlanmac='Not connected via Wifi'
else
  wlanmac=$(ifconfig | grep wlan | awk '{print $5}')
  echo "wifi mac address: $wlanmac"
fi

#Check the status of the battery
#NOTE: Uncomment the 4 lines below if running this script on a laptop.
capacity="$(cat /sys/class/power_supply/BAT0/capacity)"
echo "Charge remaining: $(capacity)%"
status="$(cat /sys/class/power_supply/BAT0/status)"
echo "Status of battery: $(status)"

#Check the screen resolution
scr=$(xdpyinfo | awk '/dimensions:/ {print $2}')
echo "Screen resolution: $scr" 

#Audio check
echo "Testing Speakers..."
cat /dev/urandom | padsp tee /dev/audio > /dev/null &
SPID=$!
( sleep 6; kill $SPID)
echo "Speaker test successful."

#Mic check
echo "Testing Microphone..."
echo "Please speak after the beep"
cat /dev/urandom | padsp tee /dev/audio > /dev/null &
MPID=$!
( sleep 3; kill $MPID )
arecord -d 10 /tmp/test1-mic.wav
echo "Mic test successful"
aplay /tmp/test1-mic.wav

#HDMI check
hdmi=''
if [ $(xrandr | grep HDMI)=='' ]
then
  hdmi="No"
else
  hdmi="Yes"
fi

#Video check

#NAND flash

#Webcam probing


#Output the contents to a CSV file
$(touch check.csv)
file='check.csv'
echo "$sno, $(nproc), $vari, $usb, $emac, $wlanmac, $scr, Yes, $hdmi " >> $file
