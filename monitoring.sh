#!/bin/bash
arc=$(uname -a)
cpup=$(cat /proc/cpuinfo | awk '$1 == "physical" {print $4}')
cpuv=$(cat /proc/cpuinfo | awk '$1 == "processor" {print $3}')
ramu=$(free --mega | awk '$1 == "Mem:" {print $3}')
ramt=$(free --mega | awk '$1 == "Mem:" {print $2}')
ramp=$(free --mega | grep 'Mem' | awk '{printf("%.2f",$3/$2*100)}')
disku=$(df --total --block-size=MB | grep 'total' | awk '{printf("%d"), $3}')
diskt=$(df --total --block-size=MB | grep 'total' | awk '{printf("%d"), $2}')
diskp=$(df --total --block-size=MB | grep 'total' | awk '{printf("%d"), $5}')
cpuu=$(top -bn1 | awk '$1 == "%Cpu(s):" {print $2}')
lb=$(who -b | awk '$1 == "system" {print $3 " " $4}')
lvm=$(lsblk |grep lvm | awk '{if ($1) {print "yes";exit;} else {print "no"}}')
tcp=$(cat /proc/net/sockstat | awk '$1 == "TCP:" {print $3}')
userlog=$(users | wc -w)
ip=$(hostname -I)
mac=$(ip link show | awk '$1 == "link/ether" {print $2}')
sudo=$(journalctl _COMM=sudo | grep 'COMMAND' | wc -l)
wall "  #Architecture: $arc
        #CPU physical: $cpup
        #vCPU: $cpuv
        #Memory Usage: $ramu/${ramt}MB ($ramp%)
        #Disk Usage: $disku/${diskt}MB ($diskp%)
        #CPU load: $cpuu%
        #Last boot: $lb
        #LVM use: $lvm
        #Connections TCP: $tcp ESTABLISHED
        #User log: $userlog
        #Network: IP $ip ($mac)
        #Sudo: $sudo cmd"
