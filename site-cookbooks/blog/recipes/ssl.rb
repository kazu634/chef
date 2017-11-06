#
# Cookbook Name:: blog
# Recipe:: ssl
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node['blog']['production']
  bash 'Create SSL certificate' do
    cwd '/home/webadm/letsencrypt'
    code <<-EOS
    ./letsencrypt-auto certonly --webroot -d #{node['blog']['FQDN']} --webroot-path /usr/share/nginx/html/ --email simoom634@yahoo.co.jp --agree-tos
    rm -f /etc/nginx/sites-enabled/maintenance
    ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
    EOS
    user 'root'
    group 'root'

    creates "/etc/letsencrypt/live/#{node['blog']['FQDN']}/"
  end

  bash 'Generating DH Key Exchange Key: this will take about 7 minutes' do
    code <<-EOS
    openssl dhparam -out /etc/letsencrypt/live/#{node['blog']['FQDN']}/dhparams_4096.pem 4096
    EOS
    user 'root'
    group 'root'

    timeout 7200
    creates "/etc/letsencrypt/live/#{node['blog']['FQDN']}/dhparams_4096.pem"
  end

  bash 'Generating TLS Session Ticket Key' do
    code <<-EOS
    openssl rand 48 > /etc/letsencrypt/live/#{node['blog']['FQDN']}/ticket.key
    EOS
    user 'root'
    group 'root'
    creates "/etc/letsencrypt/live/#{node['blog']['FQDN']}/ticket.key"
  end
end
