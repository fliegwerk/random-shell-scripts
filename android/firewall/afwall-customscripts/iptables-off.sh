#################################################
# AFWall+ CustomScript for iptables             #
# Disable Firewall                              #
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
# iptables                  #
#############################
## Variables
IPTABLES=/system/bin/iptables
IP6TABLES=/system/bin/ip6tables

#############################
# delete custom rules       #
#############################
# 
. /data/local/delete-custom-rules.sh
. /data/local/delete-tethering-rules.sh

####################
# Defaults         #
####################
# IPv4 connections
$IPTABLES -P INPUT ACCEPT
$IPTABLES -P FORWARD ACCEPT
$IPTABLES -P OUTPUT ACCEPT

# IPv6 connections
$IP6TABLES -P INPUT ACCEPT
$IP6TABLES -P FORWARD ACCEPT
$IP6TABLES -P OUTPUT ACCEPT
