set -xeu

DEFAULT_DEVICE=wlan0
DEFAULT_GATEWAY=$(nmcli -g IP4.GATEWAY device show $DEFAULT_DEVICE)
MARK=42

# exclude AndDesk
sudo iptables -t mangle -A OUTPUT -m cgroup --path system.slice/anydesk.service -j MARK --set-mark 0x$MARK
sudo ip route replace default via $DEFAULT_GATEWAY dev $DEFAULT_DEVICE table $MARK
sudo ip rule add fwmark 0x42 table $MARK priority 100 || true
sudo sysctl -w net.ipv4.conf.wlan0.rp_filter=2
sudo sysctl -w net.ipv4.conf.all.rp_filter=2

sudo ip route del default dev tun0 || true
sudo ip route add default via 172.18.0.1 dev tun0
