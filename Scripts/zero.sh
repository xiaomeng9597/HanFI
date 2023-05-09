#!/bin/sh
PHY_IFACE=ifconfig | grep  "Link" | awk '{print $1}'|grep "et"
ZT_IFACE=ifconfig | grep  "Link" | awk '{print $1}'|grep "zt"
iptables -t nat -A POSTROUTING -o $PHY_IFACE -j MASQUERADE
iptables -A FORWARD -i $PHY_IFACE -o $ZT_IFACE -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $ZT_IFACE -o $PHY_IFACE -j ACCEPT
iptables-save