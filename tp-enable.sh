sudo iptables -t nat -I OUTPUT -o eth0 -p tcp --dport 443 -m tcp -j REDIRECT --to-ports 10080
sudo iptables -t nat -I OUTPUT -o eth0 -p tcp --dport 80 -m tcp -j REDIRECT --to-ports 10081
sudo iptables -t nat -I OUTPUT -d 100.99.88.0/24 -j RETURN
sudo iptables -t nat -I OUTPUT -d 100.88.77.66 -j RETURN
sudo iptables -t nat -I PREROUTING ! -i eth0 -p tcp -m tcp --dport 443 -j REDIRECT --to-ports 10080
sudo iptables -t nat -I PREROUTING ! -i eth0 -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 10081
