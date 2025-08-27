cd /root

wget https://github.com/xmrig/xmrig/releases/download/v6.24.0/xmrig-6.24.0-linux-static-x64.tar.gz

tar -xzvf xmrig-6.24.0-linux-static-x64.tar.gz

rm xmrig-6.24.0-linux-static-x64.tar.gz

mv xmrig-6.24.0 xmrig

cd xmrig

nohup ./xmrig -a rx/0 -o eticapool.com:3333 -u 0x6e9c6f5e65b0df232f0c9986ada8101686019024.Ox-srv2 -p x -k &
