curl -s https://api.github.com/repos/syncthing/relaysrv/releases/latest \
  | awk -F': ' '/strelaysrv-linux-amd64/ && /\.tar.gz/ {gsub(/"/, "", $(NF)); system("curl -LO " $(NF))}'
echo "Grabbed latest relay server tarball"
# Above taken from https://www.jwillikers.com/one-liner-to-fetch-the-latest-github-release
tar xf /strelaysrv-linux-amd64-*.tar.gz -C /root
mv /root/str*/* /root
echo "extrated it to /root and flattened the directory"
adduser -D relay
mv /root/* /home/relay
chown -R relay:relay /home/relay
chmod -R 700 /home/relay
crontab -l | { cat; echo "@reboot /usr/bin/screen -dmS syncthingrelay su relay -s /bin/ash -c '/home/relay/strelaysrv -pools= -status-srv=:22068 -listen=:22067  -protocol=tcp4 -keys=/home/relay -debug'
"; } | crontab -
echo "added user relay, moved the stuff to it's home folder, chowned and chmodded it, and added an entry for it @reboot to crontab"
