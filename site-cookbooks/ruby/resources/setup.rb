actions :install, :nothing

default_action :install

attribute :user, :name_attribute => true, :kind_of => String, :required => true
attribute :group, :kind_of => String, :name_attribute => true
attribute :version, :kind_of => String, :default => node['ruby']['version']
attribute :gems, :kind_of => Array, :default => node['ruby']['gems']

attribute :versions, :kind_of => Array, :default => []

attr_accessor :exists
