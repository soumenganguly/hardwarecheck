#!/bin/bash

#Check the battery status of the Netbook
batterystatus=$(cat /tmp/sys/class/power_supply/BAT/uevent)
#echo $batterystatus
if [ $batterystatus == 1 ]
  then
    echo " Battery Discharging "
  else
    echo " Battery Charging"
fi


#Check the Time remaining for the battery to exhaust
max_mins=300         #Assuming 5hrs(300mins) of battery life. 
mins_left=300
charge_mins=0       #Lets start it from zero( 0% battery life)
max_charge=120      #Assuming 2hrs(120mins) of charging gives 100% battery life

#We have execute this part every minute
# 300 mins of battery_life--> 100% of battery_life
# 150 mins of charge--> 100% of battery_life(300 mins)
# So, 1 min of charge= 2mins of battery_life

                                              #Case 1: Discharging
if [ $batterystatus == 1 ]
  then
    mins_left=`expr $mins_left - 1`
    hours_left=`expr $mins_left / 60`
    mins=`expr $mins_left % 60`
    echo "$hours_left hours and $mins mins. left"
  else                                        #Case 2: Charging
    charge_mins=`expr $charge_mins + 1`
    echo " $charge_mins mins. charged"
    batt_life_on_charge=`expr $charge_mins \* 2`
    echo " $charge_mins mins. of charge = $batt_life_on_charge mins. of battery life" #We need to add this time to $mins_left
    
fi
