# SSH port change does not occur at testing environment,
# so we skip the test.

# require 'serverspec'
#
# describe file("/etc/ssh/sshd_config") do
#   it { should be_file }
#
#   it { should be_owned_by 'root' }
#   it { should be_grouped_into 'root' }
#
#   it { should be_mode 644 }
# end
#
# describe service('ssh') do
#   it { should be_enabled }
# end
#
# describe port(10022) do
#   it { should be_listening.with('tcp') }
# end
#
# describe iptables do
#   it { should have_rule '-A FWR -p tcp -m tcp --dport 10022 -j ACCEPT' }
# end
