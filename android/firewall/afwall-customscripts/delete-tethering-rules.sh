#################################################
# AFWall+ CustomScript for iptables             #
# Apply custom rules                            #
#################################################
## by fliegwerk <richter@fliegwerk.com>
## (c) 2020. MIT License

#############################
# iptables                  #
#############################
## Variables
IPTABLES=/system/bin/iptables
IP6TABLES=/system/bin/ip6tables

#############################
# tethering                 #
#############################
## allow DHCP
$IPTABLES -D "afwall-wifi-tether" -p udp -m owner --uid-owner 1052 -m udp --sport 67 --dport 68 -j RETURN || true

## allow DNS
$IPTABLES -D "afwall-wifi-tether" -p udp -m owner --uid-owner 1052 -m udp --sport 53 -j RETURN || true
$IPTABLES -D "afwall-wifi-tether" -p tcp -m owner --uid-owner 1052 -m tcp --sport 53 -j RETURN || true
