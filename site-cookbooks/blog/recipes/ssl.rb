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
    # Modify the `nginx` configuration:
    rm -f /etc/nginx/sites-enabled/*
    ln -s /etc/nginx/sites-available/maintenance /etc/nginx/sites-enabled/maintenance

    # Apply
    systemctl restart nginx.service

    /home/webadm/letsencrypt/certbot-auto certonly --webroot -d #{node['blog']['FQDN']} --webroot-path /usr/share/nginx/html/ --email simoom634@yahoo.co.jp --agree-tos -n

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

    creates "/etc/letsencrypt/live/#{node['blog']['FQDN']}/README"
  end

  cookbook_file "/etc/letsencrypt/live/#{node['blog']['FQDN']}/dhparams_4096.pem" do
    source 'dhparams_4096.pem'

    owner 'root'
    group 'root'
    mode 0644
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
