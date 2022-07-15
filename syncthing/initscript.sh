adduser -D syncthing
rc-update add syncthing
service syncthing start
service syncthing stop
mkdir /Syncthing
chown -R syncthing:syncthing /Syncthing
ls -la /var/lib/syncthing/.config/syncthing/config.xml
sed -i 's+path="/var/lib/syncthing/Sync"+path="/Syncthing"+' /var/lib/syncthing/.config/syncthing/config.xml
sed -i 's/^        <address>127.0.0.1:8384<\/address>$/        <address>0.0.0.0:8384<\/address>/' /var/lib/syncthing/.config/syncthing/config.xml
service syncthing start
