require 'spec_helper'

describe file('/opt/sensu/embedded/ssl/cert.pem') do
  it { should be_directory }

  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  it { should be_mode 644 }
end
