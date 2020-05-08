#################################################
# AFWall+ CustomScript for iptables             #
# Delete custom rules                           #
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
# Special Rules             #
#############################
# Allow loopback interface lo
$IPTABLES -D INPUT -i lo -j ACCEPT || true
$IPTABLES -D "afwall" -o lo -j ACCEPT || true

# Set a specific DNS-Server (dismail.de AdBlocking DNS-Server) for all networks except home WiFi (192.168.69.0/24)
$IPTABLES -t nat -D OUTPUT ! -s 192.168.69.0/24 -p tcp --dport 53 -j DNAT --to-destination 46.182.19.48:53 || true
$IPTABLES -t nat -D OUTPUT ! -s 192.168.69.0/24 -p udp --dport 53 -j DNAT --to-destination 46.182.19.48:53 || true

# set a specific DNS-Server for home WiFi (willst du nicht, so brauche ich Gewalt)
$IPTABLES -t nat -D OUTPUT -s 192.168.69.0/24 -p tcp --dport 53 -j DNAT --to-destination 192.168.69.5:53 || true
$IPTABLES -t nat -D OUTPUT -s 192.168.69.0/24 -p udp --dport 53 -j DNAT --to-destination 192.168.69.5:53 || true

# Force a specific NTP (ntp0.fau.de), Location: University Erlangen-Nuernberg
$IPTABLES -t nat -D OUTPUT -p tcp --dport 123 -j DNAT --to-destination 131.188.3.222:123 || true
$IPTABLES -t nat -D OUTPUT -p udp --dport 123 -j DNAT --to-destination 131.188.3.222:123 || true

# Allow captive portal check (captiveportal.kuketz.de)
$IPTABLES -D "afwall" -d 185.163.119.132 -p tcp --dport 80 -j ACCEPT || true
$IPTABLES -D "afwall" -d 185.163.119.132 -p tcp --dport 443 -j ACCEPT || true

#############################
# Incoming Traffic          #
#############################
# Allow all traffic from an established connection
$IPTABLES -D INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT || true

# All TCP sessions should begin with SYN
#$IPTABLES -A INPUT -p tcp ! --syn -m state --state NEW -s 0.0.0.0/0 -j DROP

# Prevent SYN attacks
$IPTABLES -D TCP -p tcp --match recent --update --seconds 60 --name TCP-PORTSCAN -j DROP || true
$IPTABLES -D INPUT -p tcp --match recent --set --name TCP-PORTSCAN -j DROP || true

# Accept inbound ICMP messages
$IPTABLES -D INPUT -p ICMP --icmp-type 8 -s 0.0.0.0/0 -j ACCEPT || true

# reject all missing packets
$IPTABLES -D INPUT -p tcp -j REJECT --reject-with tcp-reset || true
$IPTABLES -D INPUT -j REJECT --reject-with icmp-port-unreachable || true
