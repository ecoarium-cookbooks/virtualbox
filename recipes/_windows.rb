#
# Cookbook Name:: virtualbox::windows
# Recipe:: default
#

windows_package "Oracle VM VirtualBox #{node[:virtualbox][:version].split("-")}" do
  action :install
  source VirtualboxSource.create_url(node[:virtualbox][:version])
  checksum VirtualboxSource.get_checksum(source)
  installer_type :custom
  options "-s"
end