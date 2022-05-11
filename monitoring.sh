#!/bin/bash

RAM=$(free -m | grep Mem | awk '{print $3}')
TOTAL_RAM=$(free -m | grep Mem | awk '{print $2}')
RAM_PERCENT=$(free | grep Mem | awk '{printf("%.2f%%"), $3 / $2 * 100}')

DISK=$(df -h --total | grep total | awk '{print $3}' | sed s/G/\/)
TOTAL_DISK=$(df -h --total | grep total | awk '{print $2}' | sed s/G/\/)
DISK_PERCENT=$(df -k --total | grep total | awk '{print $5}')

LOAD=$(calc 100 - $(mpstat | grep 'all' | tr -d " " | cut -c 48-52 | tr ',' '.') | tr -d "      ")

LVM=$(lsblk | grep lvm -c)

MAC=$(ip a | grep ether | cut -c 16-32)

wall "\
       __  ___            _ __             _
      /  |/  /___  ____  (_) /_____  _____(_)___  ____ _
     / /|_/ / __ \\/ __ \/ / __/ __ \\/ ___/ / __ \\/ __ \`/
    / /  / / /_/ / / / / / /_/ /_/ / /  / / / / / /_/ /
   /_/  /_/\\____/_/ /_/_/\\__/\\____/_/  /_/_/ /_/\\__, /
   --------------------------------------------/____/-----------------------------
   #   Architecture:  $(uname -srvmo)
   #   CPU physical:  $(grep 'physical id' /proc/cpuinfo | wc -l)
   #    CPU virtual:  $(grep processor /proc/cpuinfo | wc -l)
   #   Memory Usage:  $RAM/$TOTAL_RAM MB ($RAM_PERCENT)
   #     Disk Usage:  $DISK/$TOTAL_DISK GB ($DISK_PERCENT)
   #       CPU Load:  $LOAD%
   #      Last boot:  $(who -b | tr -s " " | cut -d " " -f 4,5)
   #        LVM use:  $(if [ $LVM -ne 0 ]; then echo "yes"; else echo "no"; fi)
   # Connexions TCP:  $(netstat | grep -c ESTABLISHED) ESTABLISHED
   #        Network:  IP $(hostname -I) ($MAC)
   #       User log:  $(who | cut -d " " -f 1 | sort -u | wc -l)
   #           Sudo:  $(cat /var/log/sudo/sudo.log | grep -c COMMAND) cmd
   --------------------------------------------------------------------------------"

#                                             ___.-----.______
#                                   ___.-----'::::::::::::::::`---.___
#                _.--._            (:::;,-----'~~~~~`----::::::::::.. `-.
#   _          .'_---. `--.__       `~~'                 `~`--.:::::`..  `..
#  ; `-.____.-' ' {0} ` `--._`---.____                         `:::::::: : ::
# :_^              ~   `--.___ `----.__`----.____                ~::::::.`;':
#  :`--.__,-----.___(         `---.___ `---.___  `----.___         ~|;:,' : |
#   `-.___,---.____     _,        ._  `----.____ `----.__ `-----.___;--'  ; :
#                  `---' `.  `._    `))  ,  , , `----.____.----.____   --' :|
#                        / `,--.\    `.` `  ` ` ,   ,  ,     _.--   `-----'|'
# _.~~~~~~._____    __./'_/'     :   .:----.___ ` ` ` ``  .-'      , ,  :::'
#                 ///--\;  ____  :   :'    ____`---.___.--::     , ` ` ::'
#                 `'           _.'   (    /______     (   `-._   `-._,-'
#    ()  ()                 .-' __.-//     /_______---'       `-._   `.
#  * *(o)'      ~~~        /////    `'       ~~~~~~      ~~ ______;   ::.
#  `\ )( /*                `'`'                            /_______   _.'
#    {()}      ,     ~~~                  ~~~~~~~~           /___.---'  --__
#     !|       `                                              ~~~
#  ~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#------------------------COPYRIGHT DE L'ALIGATOR TROP BEAU----------------------------------------------
#Thank you for visiting https://asciiart.website/
#This ASCII pic can be found at
#https://asciiart.website/index.php?art=animals/reptiles/aligators

