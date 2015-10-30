#
# Cookbook Name:: jku-common
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'user::data_bag'
include_recipe 'sudo'

# Install system monitoring tool
package 'htop'

include_recipe 'git'

# Define ll alias
magic_shell_alias 'll' do
  command 'ls -la'
end

# Define www alias
magic_shell_alias 'www' do
  command 'cd /var/www && ll'
end

# Set env variable
magic_shell_environment 'TMPDIR' do
  value '/tmp'
end
