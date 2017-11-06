#
# Cookbook Name:: wekan-nginx
# Recipe:: ssl
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node['wekan-nginx']['production']
  bash 'Create SSL certificate' do
    cwd '/home/webadm/letsencrypt'
    code <<-EOS
    # Modify the `nginx` configuration:
    rm -f /etc/nginx/sites-enabled/*
    ln -s /etc/nginx/sites-available/maintenance /etc/nginx/sites-enabled/maintenance

    # Apply
    systemctl restart nginx.service

    /home/webadm/letsencrypt/certbot-auto certonly --webroot -d #{node['wekan-nginx']['FQDN']} --webroot-path /usr/share/nginx/html/ --email simoom634@yahoo.co.jp --agree-tos -n

    # Delete config
    rm -f /etc/nginx/sites-enabled/maintenance

    # Copy configuration
    for conf in `find /etc/nginx/sites-available -maxdepth 1 -type f | grep -v maintenance`; do
      tmp=`basename ${conf}`

      ln -s ${conf} /etc/nginx/sites-enabled/${tmp}
    done
    EOS
    user 'root'
    group 'root'

    creates "/etc/letsencrypt/live/#{node['wekan-nginx']['FQDN']}/"
  end

  bash 'Generating DH Key Exchange Key: this will take about 7 minutes' do
    code <<-EOS
    openssl dhparam -out /etc/letsencrypt/live/#{node['wekan-nginx']['FQDN']}/dhparams_4096.pem 4096
    EOS
    user 'root'
    group 'root'

    timeout 7200
    creates "/etc/letsencrypt/live/#{node['wekan-nginx']['FQDN']}/dhparams_4096.pem"
  end

  bash 'Generating TLS Session Ticket Key' do
    code <<-EOS
    openssl rand 48 > /etc/letsencrypt/live/#{node['wekan-nginx']['FQDN']}/ticket.key
    EOS
    user 'root'
    group 'root'
    creates "/etc/letsencrypt/live/#{node['wekan-nginx']['FQDN']}/ticket.key"
  end
end
