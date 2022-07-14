curl -s https://api.github.com/repos/syncthing/syncthing/releases/latest \
  | awk -F': ' '/syncthing-linux-amd64-/ && /\.tar.gz/ {gsub(/"/, "", $(NF)); system("curl -LO " $(NF))}'
echo "Grabbed latest relay server tarball"
# Above taken from https://www.jwillikers.com/one-liner-to-fetch-the-latest-github-release
tar xf /syncthing-linux-amd64-*.tar.gz -C /root
mv /root/syncthing-linux-amd64-*/* /root
echo "extrated it to /root and flattened the directory"
adduser -D syncthing
mv /root/* /home/syncthing
chown -R syncthing:syncthing /home/syncthing/*
chmod -R 700 /home/relay/*

