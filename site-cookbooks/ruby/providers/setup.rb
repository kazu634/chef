action :install do

  user = new_resource.user
  group = new_resource.group

  ver  = new_resource.version
  home = home_dir_of(user)

  unless @current_resource.versions.include?(ver)

    git "#{home}/.rbenv" do
      action        :sync

      repo          "git://github.com/sstephenson/rbenv.git"
      destination   "#{home}/.rbenv"
      revision      "master"

      user          user
      group         group
    end

    directory "#{home}/.rbenv/plugins" do
      owner user
      group group

      mode 0755
    end

    git "#{home}/.rbenv/plugins/ruby-build" do
      action        :sync

      repo          "git://github.com/sstephenson/ruby-build.git"
      destination   "#{home}/.rbenv/plugins/ruby-build"
      revision      "master"

      user          user
      group         group
    end

    script "install ruby" do
      interpreter "bash"

      user "root"
      group "root"

      timeout 7200

      cwd "#{home}/"

      code <<-EOH
        su - #{user} -c "#{home}/.rbenv/bin/rbenv install #{ver}"
        su - #{user} -c "#{home}/.rbenv/bin/rbenv rehash"
        su - #{user} -c "#{home}/.rbenv/bin/rbenv global #{ver}"
      EOH
    end

    template "#{home}/.bash_profile" do
      cookbook "ruby"

      source "bash_profile"

      owner user
      group group
    end

  end

  # Already installed Ruby,
  # so the gem command should be available at this point.
  unless @new_resource.gems - @current_resource.gems  ==  []

    gems = @new_resource.gems - @current_resource.gems

    gems.each do |g|

      gem_package g do
        gem_binary "#{home}/.rbenv/shims/gem"
      end

    end

    script "rbenv rehash" do
      interpreter "bash"

      user "root"
      group "root"

      code <<-EOH
      su - #{user} -c "#{home}/.rbenv/bin/rbenv rehash"
      EOH
    end

  end


  unless @current_resource.versions.include?(ver) and @new_resource.gems - @current_resource.gems  ==  []

    new_resource.updated_by_last_action(true)

  end

end

def load_current_resource
  @current_resource = Chef::Resource::RubySetup.new(@new_resource.name)

  @current_resource.user(@new_resource.name)
  @current_resource.version(@new_resource.version)

  user = @new_resource.user
  group = @new_resource.group
  ver = @new_resource.version

  home = home_dir_of(user)

  if FileTest.exists?("#{home}/.rbenv/bin/rbenv")

    @current_resource.versions(`su - #{user} -c "#{home}/.rbenv/bin/rbenv versions | sed -r -e 's/^..//' | cut -f 1 -d ' '"`.split("\n"))

  else

    @current_resource.versions([])

  end

  if FileTest.exists?("#{home}/.rbenv/versions/#{ver}/bin/gem")

    @current_resource.gems(`su - #{user} -c "#{home}/.rbenv/versions/#{ver}/bin/gem list | grep '^[a-zA-Z0-9]' | cut -f 1 -d ' '"`.split("\n"))

  else

    @current_resource.gems([])

  end
end


private

def home_dir_of(user)

  return `grep #{user} /etc/passwd | cut -f 6 -d ":"`.chomp

end
