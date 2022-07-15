./start.sh VMID# containername MBram IP-Address


Will start a syncthing instance, where it's default folder is /Syncthing and listens on 8384 for the webui.

Adds instance to firewall group syncthing-main

In the Example private script

DEVICE-ID=LongDeviceIDofIt
RELAYADDRESS=relay://fqdnorIP:PORT//?id=DeviceIDofit

Device-ID is a syncthing device you'd like added as an introducer, and autoaccepter.

Relay Address is the address of a private relay you've set up, if you don't want to depend on NAT transversal, or 3rd parties helping you punch through NAT.
