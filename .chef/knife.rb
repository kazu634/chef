cookbook_path ["cookbooks", "site-cookbooks"]
node_path     "nodes"
role_path     "roles"
environment_path "environments"
data_bag_path "data_bags"
encrypted_data_bag_secret ".chef_databag_secret"

knife[:berkshelf_path] = "cookbooks"
knife[:berkshelf] = false
