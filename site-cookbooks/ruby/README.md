ruby Cookbook
=============
Install Ruby under the specified user's home directory.

Usage
-----
#### ruby::default
Add the `include_recipe "ruby"` to your recipe. Then insert the following sentences:

```
ruby_setup "user_name" do

  action :install

  user "user_name"
  group "group_name"

  version "1.9.3-p374"
end
```

- user: This cookbook will install Ruby under the specified user's home directory.
- group: The group owner of /home/user/.rbenv
- version: The version of Ruby this cookbook will install.
