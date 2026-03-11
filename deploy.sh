#!/usr/bin/env bash
sudo apt update && sudo apt install nodejs npm
# Install pm2 globally to manage and keep the app running in the background
sudo npm install -g pm2
# Stop the simpleapp process if it is already running
pm2 stop simpleapp
# Navigate into the cloned application directory
cd SimpleApplication/
# Install all required npm packages
npm install

# Decode base64-encoded secrets from CI environment variables into files
echo "$PRIVATE_KEY" | base64 -d > privatekey.pem
echo "$SERVER" | base64 -d > server.crt

# Redirect ports 80 and 443 to 8443 where the app listens
sudo iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 8443
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8443

# Launch the app using pm2 so it restarts automatically on crash
pm2 start ./bin/www --name simpleapp
