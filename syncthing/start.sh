#!/bin/bash
# $1 VMID
# $2 Hostname 
# $3 Memory in MB
# $4 static IP

echo "[RULES]" >> /etc/pve/firewall/$1.fw
echo "GROUP syncthing-main" >> /etc/pve/firewall/$1.fw

pct create $1 \
local:vztmpl/alpine-3.16-default_20220622_amd64.tar.xz \
--cmode shell  \
--console 1  \
--cores 2  \
--hostname $2  \
--memory $3  \
--net0 bridge=vmbr0,firewall=1,gw=192.168.1.1,ip=$4/24,name=eth0  \
--onboot 1  \
--ssh-public-keys ~/.ssh/authorized_keys  \
--start 1  \
--swap 0  \
--features nesting=1  \
-mp0 /media/syncthing,mp=/Syncthing,ro=1 \
--rootfs volume=local-lvm:1,mountoptions=noatime
echo "Created LXC Container with VMID $1 with hostname $2 allowing it to have $3MB of ram, with a static ip of $4"
pct exec $1 apk add syncthing
echo "Adding Syncthing, copying scripts over, and adding syncthing to autostart, then start/stopping it so config files are generated."
pct push $1 ./initscript.sh /root/initscript.sh
pct push $1 ./privscript.sh /root/privscript.sh
pct exec $1 -- /bin/ash -c "rc-update add syncthing"
pct exec $1 -- /bin/ash -c "service syncthing start"
pct exec $1 -- /bin/ash -c "service syncthing stop"
echo "rebooting VMID $1"
pct reboot $1
echo "rebooted VMID $1"
echo "Running initscript.sh"
pct exec $1 -- /bin/ash -c "sh /root/initscript.sh"
echo "running privscript.sh"
pct exec $1 -- /bin/ash -c "sh /root/privscript.sh"
echo "rebooting VMID $1"
pct reboot $1
echo "rebooted VMID $1"
