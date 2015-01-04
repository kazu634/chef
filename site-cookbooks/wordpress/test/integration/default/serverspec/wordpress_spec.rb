require 'serverspec'

set :backend,  :exec

describe file('/var/www/nginx-default/domain/wordpress') do
  it { should be_owned_by 'www-data' }
  it { should be_grouped_into 'root' }

  it { should be_mode 755 }
end

tmp_dirs = %w(/var/www/proxy/blog_cache
              /var/www/proxy/blog_tmp)

tmp_dirs.each do |d|
  describe file(d) do
    it { should be_owned_by 'www-data' }
    it { should be_grouped_into 'root' }

    it { should be_mode 755 }

    it { should be_mounted.with(type: 'tmpfs') }
  end
end

describe file('/var/www/nginx-default/domain/wordpress/wp-content') do
  it { should be_directory }
end
