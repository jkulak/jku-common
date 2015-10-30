#
# Cookbook Name:: jku-common
# Definition:: versioned_dir_structure
#
# Copyright 2015, Jakub Kułak
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Create versioned and symlinked directory structure
define :versioned_dir_structure, :docroot_dir => '/var/www' do

    # include_recipe 'apache2::default'
    # conf_name = "#{params[:example]}.conf"
    # params[:conf_path] = params[:conf_path] || "#{node['apache']['dir']}/conf-available"
    # if params[:enable]

    dir = params[:name]
    docroot_dir = params[:docroot_dir] # || node['apache']['docroot_dir']
    user = params[:user] # || node['apache']['user']
    group = params[:group] # || node['apache']['group']

    # Create main vhost directory
    directory "#{docroot_dir}/#{dir}" do
        # mode 00755
        action :create
        user user
        group group
    end

    # Create initial release repository
    directory "#{docroot_dir}/#{dir}/releases" do
        action :create
        user user
        group group
    end

    # Create initial release repository
    directory "#{docroot_dir}/#{dir}/releases/initial" do
        action :create
        user user
        group group
    end

    # Empty directory for /releases/previous symlink
    directory "#{docroot_dir}/#{dir}/releases/preinitial" do
        action :create
        user user
        group group
    end

    # Create current symlinks
    link "#{docroot_dir}/#{dir}/releases/current" do
        to "#{docroot_dir}/#{dir}/releases/initial"
        user user
        group group
    not_if { ::File.exists?("#{docroot_dir}/#{dir}/releases/current") }
    end

    # Create previous symlink
    link "#{docroot_dir}/#{dir}/releases/previous" do
        to "#{docroot_dir}/#{dir}/releases/preinitial"
        user user
        group group
    not_if { ::File.exists?("#{docroot_dir}/#{dir}/releases/previous") }
    end

    # Create current->www symlink
    link "#{docroot_dir}/#{dir}/www" do
        to "#{docroot_dir}/#{dir}/releases/current"
        user user
        group group
    not_if { ::File.exists?("#{docroot_dir}/#{dir}/www") }
    end

end
