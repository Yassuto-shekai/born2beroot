#!/bin/bash

my_arch=$(uname --all)

my_phycpu=$(cat /proc/cpuinfo | grep -w 'physical id' | sort -u | wc -l)

my_vcpu=$(cat /proc/cpuinfo | grep -w 'processor' | wc -l)

my_aviram=$(free -m | awk '/Mem:/ {printf("%i", $2)}')

my_useram=$(free -m | awk '/Mem:/ {printf("%i", $3)}')

my_ramper=$(free | awk '/Mem:/ {printf("%.2f%%", $3/$2 * 100)}')

my_disk=$(df -BG)

my_usedisk=$(df -BM --total | grep -w total | awk '{printf("%i", $2 - $4)}')

my_diskper=$(df -BM --total | grep -w total | awk '{printf("%.2f", (($2 - $4)/$2) * 100)}')

my_cpuload=$(uptime | awk '{printf("%.2f%%", ((($9 + $10 + $11) / 3) * 100))}')

my_lastboot=$(who -b | awk '{print $3, $4}')

my_LVM=$(if [ $(lsblk | grep -c LVM | wc -l) -gt 0 ]; then echo "yes"; else echo "no"; fi)

str='ESTABLISHED'

my_tcp=$(ss -t state $str | wc -l)

my_userlog=$(who | wc -l)

my_ip=$(hostname -I)

my_sudo=$(journalctl _COMM=sudo | grep -w COMMAND | wc -l)

mac_address=$(ip link | grep -w link/ether | awk '{print $2}')

wall "#Architecture: $my_arch
#CPU physical : $my_phycpu
#vCPU : $my_vcpu 
#Memory Usage: $my_useram/$my_aviram Mb ($my_ramper)
#Disk Usage: $my_usedisk/$my_disk Gb ($my_diskper%)
#CPU load: $my_cpuload
#Last boot: $my_lastboot
#LVM use: $my_LVM 
#Connections TCP : $my_tcp $str
#User log: $my_userlog
#Network: IP $my_ip ($mac_address)
#Sudo : $my_sudo cmd"

