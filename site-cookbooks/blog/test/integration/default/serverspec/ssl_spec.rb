# require 'serverspec'
#
# set :backend,  :exec
#
# describe file('/etc/letsencrypt/live/blog.kazu634.com') do
#   it { should be_directory }
# end
#
# %w( dhparams_4096.pem ticket.key ).each do |key|
#   describe file("/etc/letsencrypt/live/blog.kazu634.com/#{key}") do
#     it { should be_file }
#   end
# end
#
# describe file('/home/webadm/bin/ssl_reneal.sh') do
#   it { should be_file }
#   it { should be_owned_by 'webadm'}
#   it { should be_grouped_into 'webadm'}
#   it { should be_mode 755 }
# end
#
# describe file('/etc/cron.d/ssl') do
#   it { should be_file }
#   it { should be_owned_by 'root'}
#   it { should be_grouped_into 'root'}
#   it { should be_mode 644 }
# end
