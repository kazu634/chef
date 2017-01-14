#!/bin/bash

# Preparation for maintenance:
rm -f /etc/nginx/sites-enabled/default
rm -f /etc/nginx/sites-enabled/blog
ln -s /etc/nginx/sites-available/maintenance /etc/nginx/sites-enabled/maintenance

# Start maintenance:
touch /tmp/maintenance

# Reload `nginx` configuration:
service nginx reload

# Renewal SSL certificate:
/home/webadm/letsencrypt/letsencrypt-auto certonly --webroot -d blog.kazu634.com --webroot-path /usr/share/nginx/html/ --email simoom634@yahoo.co.jp --agree-tos --renew-by-default

sleep 5

# Stop maintenance:
rm /tmp/maintenance

# Preparation for normal operation:
rm -f /etc/nginx/sites-enabled/maintenance
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/blog /etc/nginx/sites-enabled/blog

# Reload `nginx` configuration:
service nginx reload

exit 0
