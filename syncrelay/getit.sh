curl -s https://api.github.com/repos/syncthing/relaysrv/releases/latest \
  | awk -F': ' '/strelaysrv-linux-amd64/ && /\.tar.gz/ {gsub(/"/, "", $(NF)); system("curl -LO " $(NF))}'
tar xf /strelaysrv-linux-amd64-*.tar.gz -C /root
mv /root/str*/* /root
adduser -D relay
mv /root/* /home/relay
chown -R relay:relay /home/relay
chmod -R 700 /home/relay
crontab -l | { cat; echo "@reboot /usr/bin/screen -dmS syncthingrelay su relay -s /bin/ash -c '/home/relay/strelaysrv -pools= -status-srv=:22068 -listen=:22067  -protocol=tcp4 -keys=/home/relay -debug'
"; } | crontab -
