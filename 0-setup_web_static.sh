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

	echo "Hello World!" | sudo tee /var/www/html/index.debian.html
	sudo service nginx restart
fi

# create folders && subfolders
mkdir -p "/data/" && cd "data"
mkdir -p "web_static" && cd "web_static"
mkdir -p "releases" "shared" && cd "releases"
mkdir -p "test" && cd "test" && touch index.html

# populate test file
CONTENT="<!doctype html>
<html>
<head>
    <title>Test Page</title>

    <meta charset='utf-8' />
    <meta http-equiv='Content-type' content='text/html; charset=utf-8' />
    <meta name='viewport' content='width=device-width, initial-scale=1' />
</head>

<body>
<div>
    <h1>Test Page</h1>
    <p>Test NGINX configuration........</p>
</div>
</body>
</html>"

echo $CONTENT > index.html

# delte  symbolic link if exists and create new symlink 
if [ -L /data/web_static/current ]; then
	rm /data/web_static/current
fi

ln -s /data/web_static/releases/test/ /data/web_static/current

# change ownership of directory and contents
sudo chown -R ubuntu:ubuntu /data/

# INSERT NGINX CONFIG WITH ALIAS HERE
sudo sed -i '/last line/ a    \\tlocation \/hbnb_static\/ {\n\t\talias \/data\/web_static\/current\/;\n\t}'

# restart NGINX
sudo service nginx restart
