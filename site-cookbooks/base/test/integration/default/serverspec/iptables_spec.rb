require 'serverspec'

describe iptables do
  it { should have_rule '-A FWR -m state --state RELATED,ESTABLISHED -j ACCEPT' }
  it { should have_rule '-A FWR -p icmp -j ACCEPT' }

  # Since `serverspec` iptables cannot handle '[' and ']' properly, we just skip:
  # it { should have_rule '-A FWR -m limit --limit 3/hour -j LOG --log-prefix "[Packet Dropped] "' }

  it { should have_rule '-A FWR -p tcp -m tcp --tcp-flags SYN,RST,ACK SYN -j DROP' }
  it { should have_rule '-A FWR -p udp -j DROP' }
  it { should have_rule '-A INPUT -j FWR' }
  it { should have_rule '-A FWR -i lo -j ACCEPT' }
end

# Skip `ssh` iptables rule test:
# describe iptables do
#   it { should have_rule '-A FWR -p tcp -m tcp --dport 10022 -j ACCEPT' }
# end
