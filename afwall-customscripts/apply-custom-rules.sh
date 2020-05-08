#################################################
# AFWall+ CustomScript for iptables             #
# Apply custom rules                            #
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
$IPTABLES -C INPUT -i lo -j ACCEPT || \
$IPTABLES -A INPUT -i lo -j ACCEPT
$IPTABLES -C "afwall" -o lo -j ACCEPT || \
$IPTABLES -A "afwall" -o lo -j ACCEPT

# Set a specific DNS-Server (dismail.de AdBlocking DNS-Server) for all networks except home WiFi (192.168.69.0/24)
$IPTABLES -t nat -C OUTPUT ! -s 192.168.69.0/24 -p tcp --dport 53 -j DNAT --to-destination 46.182.19.48:53 || \
$IPTABLES -t nat -I OUTPUT ! -s 192.168.69.0/24 -p tcp --dport 53 -j DNAT --to-destination 46.182.19.48:53
$IPTABLES -t nat -C OUTPUT ! -s 192.168.69.0/24 -p udp --dport 53 -j DNAT --to-destination 46.182.19.48:53 || \
$IPTABLES -t nat -I OUTPUT ! -s 192.168.69.0/24 -p udp --dport 53 -j DNAT --to-destination 46.182.19.48:53

# set a specific DNS-Server for home WiFi (And if you're not willing, then I'll use force)
$IPTABLES -t nat -C OUTPUT -s 192.168.69.0/24 -p tcp --dport 53 -j DNAT --to-destination 192.168.69.5:53 || \
$IPTABLES -t nat -I OUTPUT -s 192.168.69.0/24 -p tcp --dport 53 -j DNAT --to-destination 192.168.69.5:53
$IPTABLES -t nat -C OUTPUT -s 192.168.69.0/24 -p udp --dport 53 -j DNAT --to-destination 192.168.69.5:53 || \
$IPTABLES -t nat -I OUTPUT -s 192.168.69.0/24 -p udp --dport 53 -j DNAT --to-destination 192.168.69.5:53

# Force a specific NTP (ntp0.fau.de), Location: University Erlangen-Nuernberg
$IPTABLES -t nat -C OUTPUT -p tcp --dport 123 -j DNAT --to-destination 131.188.3.222:123 || \
$IPTABLES -t nat -A OUTPUT -p tcp --dport 123 -j DNAT --to-destination 131.188.3.222:123
$IPTABLES -t nat -C OUTPUT -p udp --dport 123 -j DNAT --to-destination 131.188.3.222:123 || \
$IPTABLES -t nat -A OUTPUT -p udp --dport 123 -j DNAT --to-destination 131.188.3.222:123

# Allow captive portal check (captiveportal.kuketz.de)
$IPTABLES -C "afwall" -d 185.163.119.132 -p tcp --dport 80 -j ACCEPT || \
$IPTABLES -A "afwall" -d 185.163.119.132 -p tcp --dport 80 -j ACCEPT
$IPTABLES -C "afwall" -d 185.163.119.132 -p tcp --dport 443 -j ACCEPT || \
$IPTABLES -A "afwall" -d 185.163.119.132 -p tcp --dport 443 -j ACCEPT

#############################
# Incoming Traffic          #
#############################
# Allow all traffic from an established connection
$IPTABLES -C INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT || \
$IPTABLES -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# All TCP sessions should begin with SYN
#$IPTABLES -A INPUT -p tcp ! --syn -m state --state NEW -s 0.0.0.0/0 -j DROP

# Prevent SYN attacks
$IPTABLES -C TCP -p tcp --match recent --update --seconds 60 --name TCP-PORTSCAN -j DROP || \
$IPTABLES -I TCP -p tcp --match recent --update --seconds 60 --name TCP-PORTSCAN -j DROP
$IPTABLES -C INPUT -p tcp --match recent --set --name TCP-PORTSCAN -j DROP || \
$IPTABLES -A INPUT -p tcp --match recent --set --name TCP-PORTSCAN -j DROP

# Accept inbound ICMP messages
$IPTABLES -C INPUT -p ICMP --icmp-type 8 -s 0.0.0.0/0 -j ACCEPT || \
$IPTABLES -A INPUT -p ICMP --icmp-type 8 -s 0.0.0.0/0 -j ACCEPT

# Reject all unhandled packets
$IPTABLES -C INPUT -p tcp -j REJECT --reject-with tcp-reset || \
$IPTABLES -A INPUT -p tcp -j REJECT --reject-with tcp-reset
$IPTABLES -C INPUT -j REJECT --reject-with icmp-port-unreachable || \
$IPTABLES -A INPUT -j REJECT --reject-with icmp-port-unreachable
