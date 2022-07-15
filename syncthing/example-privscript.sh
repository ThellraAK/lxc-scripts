DEVICE-ID=LongDeviceIDofIt
RELAYADDRESS=relay://fqdnorIP:PORT//?id=DeviceIDofit
USERNAME=changeme
PASSWORD=noreally

sed -i 's+        <listenAddress>default</listenAddress>+        <listenAddress>default</listenAddress>\n        <listenAddress>$RELAYADDRESS</listenAddress>+' /var/lib/syncthing/.config/syncthing/config.xml
cat /var/lib/syncthing/.config/syncthing/config.xml | grep "listenAddress"

apikey=$(xmllint --xpath "*/*/apikey/text()"  /var/lib/syncthing/.config/syncthing/config.xml)
myip=$(hostname -i)
echo $apikey
sleep 10
curl -X PUT -H "X-API-Key: $apikey"  -d '
{
  "deviceID": "$DEVICE-ID",
  "name": "pop-os",
  "addresses": [
    "dynamic"
  ],
  "compression": "metadata",
  "certName": "",
  "introducer": true,
  "skipIntroductionRemovals": false,
  "introducedBy": "",
  "paused": false,
  "allowedNetworks": [],
  "autoAcceptFolders": true,
  "maxSendKbps": 0,
  "maxRecvKbps": 0,
  "ignoredFolders": [],
  "maxRequestKiB": 0,
  "untrusted": false,
  "remoteGUIPort": 0
}

'   http://$myip:8384/rest/config/devices/$DEVICE-ID

curl -X PATCH -H "X-API-Key: $apikey"  -d '
{
  "user": "$USERNAME",
  "password": "$PASSWORD"
} ' http://$myip:8384/rest/config/gui
