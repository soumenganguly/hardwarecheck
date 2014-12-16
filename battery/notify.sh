#!/bin/bash

power=$(cat power.txt)
hours=`expr power / 60`
mins=`expr power % 60`
notify-send "echo '$hours hours $mins mins. remaining"
