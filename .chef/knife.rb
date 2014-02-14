cookbook_path ["cookbooks", "site-cookbooks"]
role_path     "roles"
data_bag_path "data_bags"
encrypted_data_bag_secret ".chef_databag_secret"

knife[:aws_access_key_id]       = "#{ENV['AWS_ACCESS_KEY']}"
knife[:aws_secret_access_key]   = "#{ENV['AWS_SECRET_KEY']}"
knife[:region]                  = "#{ENV['EC2_REGION']}"
knife[:availability_zone]       = "#{ENV['EC2_AVAILABILITY_ZONE']}"
knife[:ssh_user]                = "ubuntu"
knife[:groups]                  = "default"

knife[:berkshelf_path] = "cookbooks"
knife[:berkshelf]      = false
