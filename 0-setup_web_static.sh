#!/usr/bin/env bash
# script to set up web servers for deployment of AirBnB_clone webstatic

# check for NGINX and install if not found
if (( "$ which nginx | grep - nginx > /dev/null"  == 0 ));then
	echo "Already installed";
else
	echo "Begin installation"
	sudo apt-get update
	sudo apt-get install -y nginx
	sudo ufw allow  'Nginx HTTP'

fi

# create folders && subfolders
mkdir -p "/data/web_static/shared." 
mkdir -p "/data/web_static/releases/test/"

# mkdir -p "web_static" && cd "web_static"
# mkdir -p "releases" "shared" && cd "releases"

cd /data/web_static/releases/test && touch index.html

# populate test file
CONTENT="<!doctype html>
<html>
<head>
</head>

<body>
<div>
    <h1>Test Page</h1>
    <p>Test NGINX configuration........</p>
</div>
</body>
</html>"

echo "$CONTENT" | sudo tee  index.html

# delte  symbolic link if exists and create new symlink 
#if [ -L /data/web_static/current ]; then
#	rm /data/web_static/current
#fi

sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# change ownership of directory and contents
sudo chown -R ubuntu:ubuntu /data/

# INSERT NGINX CONFIG WITH ALIAS HERE
sudo sed -i '/server_name _;/ a    \\tlocation \/hbnb_static\/ {\n\t\talias \/data\/web_static\/current\/;\n\t}' /etc/nginx/sites-available/default

# restart NGINX
sudo service nginx restart
