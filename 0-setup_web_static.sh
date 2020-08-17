#!/usr/bin/env bash
# This script sets up your web servers for the deployment of web_static.

# Install Nginx if it not already installed.

if ! command -v nginx &> /dev/null; then
    apt-get update
    apt-get -y install nginx
fi

# Create the necessary folders if they don't exist.

mkdir -p /data/web_static/shared/
mkdir -p /data/web_static/releases/test/

# Create a fake HTML file

text="<html>\n\t<head>\n\t</head>\n\t<body>\n\t\tHolberton School\n\t</body>\n</html>"
echo -e "$text"  > /data/web_static/releases/test/index.html

# Create a symbolic link
# (If the symbolic link already exists, it should be deleted and recreated)

symbolic_link="/data/web_static/current"

ln -sf /data/web_static/releases/test/ "$symbolic_link"

# Change ownership and group of files.

chown -R ubuntu:ubuntu /data/

# Chnage Nginx configuration.

file="/etc/nginx/sites-available/default"
text="server {\n\tlocation \/hbnb_static {\n\t\talias \/data\/web_static\/current\/;\n\t}\n"

if ! grep -Fq "location /hbnb_static {" "$file"; then
    sed -i "0,/^server {/s//$text/" "$file"
fi

service nginx restart
