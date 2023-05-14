#!/bin/sh
PHY_IFACE=$(ifconfig | grep "Link" | awk '{print $1}' | grep "eth" | head -n1)
ZT_IFACE=$(ifconfig | grep "Link" | awk '{print $1}' | grep "zt" | head -n1)
iptables -t nat -A POSTROUTING -o $PHY_IFACE -j MASQUERADE
iptables -A FORWARD -i $PHY_IFACE -o $ZT_IFACE -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $ZT_IFACE -o $PHY_IFACE -j ACCEPT
#iptables-save
