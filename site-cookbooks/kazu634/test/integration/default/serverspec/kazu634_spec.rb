require 'serverspec'

set :backend, :exec

describe user('kazu634') do
  it { should exist }
  it { should have_home_directory '/home/kazu634' }
  it { should have_login_shell '/bin/zsh' }
end

describe file('/home/kazu634/repo/dotfiles') do
  it { should be_directory }
end

describe file('/etc/sudoers.d/kazu634') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }

  its(:md5sum) { should eq '2bab24660d24494cd94a0c0ae92b9bb8' }
end

describe file('/home/kazu634/src') do
  it { should be_directory }
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
  it { should be_mode 755 }
end

describe file('/home/kazu634/tmp') do
  it { should be_directory }
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
  it { should be_mode 755 }
end

describe file('/home/kazu634/works') do
  it { should be_directory }
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
  it { should be_mode 755 }
end

describe file('/etc/cron.d/remove_tmp') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }

  its(:md5sum) { should eq 'c0bf959092009acce3471adf51439845' }
end

describe file('/home/kazu634/.aws_setuprc') do
  it { should be_owned_by 'kazu634' }
  it { should be_grouped_into 'kazu634' }
  it { should be_mode 600 }

  its(:md5sum) { should eq '69467e5ddcb2acd9c8b802d75f189692' }
end

describe file('/usr/local/bin/git-now') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 755 }
end
