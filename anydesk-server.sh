set -xeu

export LANG="en_US.UTF8"
export XDG_RUNTIME_DIR=/run/user/$(id -u)
mkdir -p "$XDG_RUNTIME_DIR"

export DISPLAY=:1

# audio
pipewire &
wireplumber &
pipewire-pulse &

eval $(dbus-launch --sh-syntax)
Xvfb :1 &

sysctl -w net.ipv4.ip_forward=1

nft add table ip nat
nft add chain ip nat postrouting '{ type nat hook postrouting priority 100; }'
nft add rule ip nat postrouting oifname "eth0" masquerade

nft add table ip filter
nft add chain ip filter forward '{ type filter hook forward priority 0; policy drop; }'
nft add rule ip filter forward iifname "tun0" oifname "eth0" accept
nft add rule ip filter forward iifname "eth0" oifname "tun0" ct state related,established accept

systemctl stop anydesk
anydesk --service &
