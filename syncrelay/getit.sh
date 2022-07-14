curl -s https://api.github.com/repos/syncthing/relaysrv/releases/latest \
  | awk -F': ' '/strelaysrv-linux-amd64/ && /\.tar.gz/ {gsub(/"/, "", $(NF)); system("curl -LO " $(NF))}'
tar xf /strelaysrv-linux-amd64-*.tar.gz -C /root
mv /root/str*/* /root
crontab -l | { cat; echo "/usr/bin/screen -dmS syncthingrelay su relay -c '/home/relay/strelaysrv -pools= -status-srv=:22068 -listen=:22067  -protocol=tcp4 -debug'
"; } | crontab -
