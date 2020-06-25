#################################################
# AFWall+ CustomScript for iptables             #
# Enable Firewall                               #
#################################################
## by fliegwerk <richter@fliegwerk.com>
## (c) 2020. MIT License
##
## template from Mike Kuketz
## www.kuketz-blog.de
##
## iptables -L
## iptables -S
## iptables -L -t nat

#############################
# Tweaks                    #
#############################
## Kernel
# Disable IPv6
echo 0 > /proc/sys/net/ipv6/conf/wlan0/accept_ra
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
echo 1 > /proc/sys/net/ipv6/conf/default/disable_ipv6
# Privacy IPv6 Address
echo 2 > /proc/sys/net/ipv6/conf/all/use_tempaddr
echo 2 > /proc/sys/net/ipv6/conf/default/use_tempaddr

#############################
# iptables                  #
#############################
## Variables
IPTABLES=/system/bin/iptables
IP6TABLES=/system/bin/ip6tables

## Clear
# Flush/Purge all rules (DANGER!!!)
# This removes the oem routing entries
# and after 24 hours no more routing is possible!
#$IPTABLES -F INPUT
#$IPTABLES -F OUTPUT
#$IPTABLES -F -t nat

#############################
# Defaults                  #
#############################
# IPv4 connections
$IPTABLES -P INPUT DROP
$IPTABLES -P FORWARD DROP
$IPTABLES -P OUTPUT DROP

# IPv6 connections
$IP6TABLES -P INPUT DROP
$IP6TABLES -P FORWARD DROP
$IP6TABLES -P OUTPUT DROP

#############################
# check/apply custom rules  #
#############################
# comment out what you don't like
. /data/local/apply-custom-rules.sh
. /data/local/apply-tethering-rules.sh
