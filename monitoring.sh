#!/bin/bash

#wall display message to all 
archi=$(uname -a)
cpuphysical=$(lscpu | grep "CPU(s):" | head -1 | cut -d ':' -f2 | tr -d ' ')
vcpu=$(grep "^processor" /proc/cpuinfo | wc -l)
fram=$(free -m | awk '$1 == "Mem:" {print $2}')
uram=$(free -m | awk '$1 == "Mem:" {print $3}')
pram=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')
diskusg=$(df -h --total | grep total | awk '{printf("%.1f/%.fGb (%s)\n", $3, $2, $5)}')
cpul=$(top -bn1 | grep "Cpu" | cut -d "," -f2 | cut -c 3- | cut -c -3)
#lastboot
lastboot=$(who -b | tr -s ' ' | cut -d ' ' -f4-5)
lvmcount=$(lsblk | grep "lvm" | wc -l)
lvmres=$(if [ $lvmt -eq 0 ]; then echo no; else echo yes; fi)

#connexion tcp
tcp=$(netstat | grep "ESTABLISHED" | wc -l)

#adresse ip -parsing
ipadress=$(ip link show |tail -1 | tr -s ' ' | cut -d ' ' -f3)

#user log
usr=$(users | wc -w)

#lister les commande sudo
lstsudo=$(journalctl _COMM=sudo | grep COMMAND | wc -l)
wall "#Architecture: $archi
#CPU physical : $cpuphysical
#vCPU : $(grep "^processor" /proc/cpuinfo | wc -l)
#Memory usage : $uram/${fram}MB ($pram%)
#Disk Usage: $diskusg
#CPU load: $cpul%
#Last boot: $lastboot
#LVM use: $lvmres
#Connexions TCP : $tcp ETABLISHED
#User log: $usr
#Network: IP `hostname -I`($ipadress)
#Sudo : $lstsudo cmd"

