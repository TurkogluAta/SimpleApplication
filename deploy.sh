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

# Write environment variables to files, restoring newlines lost in CI
echo "$PRIVATE_KEY" | tr ' ' '\n' > privatekey.pem
echo "$SERVER" | tr ' ' '\n' > server.crt

# Launch the app using pm2 so it restarts automatically on crash
pm2 start ./bin/www --name simpleapp
