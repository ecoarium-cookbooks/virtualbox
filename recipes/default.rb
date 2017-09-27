#
# Cookbook Name:: virtualbox
# Recipe:: default
#

VirtualboxSource.base_url = node[:virtualbox][:base_url]

case node['platform']
when 'mac_os_x'
 VirtualboxSource.file_extension = node[:virtualbox][:osx][:file_extension]
 VirtualboxSource.checksum_extension = node[:virtualbox][:osx][:file_extension].split(".")[1]
 include_recipe 'virtualbox::_osx'
when 'windows'
  VirtualboxSource.file_extension = node[:virtualbox][:windows][:file_extension]
  VirtualboxSource.checksum_extension = node[:virtualbox][:windows][:file_extension].split(".")[1]
  include_recipe 'virtualbox::_windows'
else
  Chef::Application.fatal!("this OS is not supported: #{node['platform']}")
end