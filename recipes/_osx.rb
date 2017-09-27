#
# Cookbook Name:: virtualbox::osx
# Recipe:: default
#

if File.exists? '/usr/local/bin/VBoxManage'
  installed_version = `VBoxManage --version`
  installed_version.chomp!

  Chef::Application.fatal! "

the existing installation of virtualbox is not properly installed:

    #{installed_version}

manual intervention is required!!!

" if installed_version =~ /vboxdrv kernel module is not loaded/
  
  installed_version_number, installed_build_number = installed_version.split('r')

  Chef::Log.debug "current virtualbox version: '#{installed_version_number}-#{installed_build_number}'
required virtualbox version: '#{node[:virtualbox][:version]}'"
  
  unless "#{installed_version_number}-#{installed_build_number}" == "#{node[:virtualbox][:version]}"
    Chef::Log.debug 'the current installation of virtualbox will be uninstalled'
    
    url_for_version_to_uninstall = VirtualboxSource.create_url("#{installed_version_number}-#{installed_build_number}")
    remote_file "#{Chef::Config[:file_cache_path]}/#{File.basename(url_for_version_to_uninstall)}" do
      source url_for_version_to_uninstall
      checksum lazy{ VirtualboxSource.get_checksum(url_for_version_to_uninstall) }
    end
    
    execute "hdiutil attach #{Chef::Config[:file_cache_path]}/#{File.basename(url_for_version_to_uninstall)}"
    
    execute "ps -axco 'pid command' | grep -wEe '(VirtualBox|VirtualBoxVM|VBoxManage|VBoxHeadless|vboxwebsrv|VBoxXPCOMIPCD|VBoxSVC|VBoxNetDHCP|VBoxNetNAT)' | grep -vw grep | grep -vw VirtualBox_Uninstall.tool | awk '{print $1}' | xargs kill -KILL"

    execute '/Volumes/VirtualBox/VirtualBox_Uninstall.tool --unattended'

    execute "hdiutil detach '/Volumes/Virtualbox'"
  end
end

url = VirtualboxSource.create_url(node[:virtualbox][:version])

dmg_package 'Virtualbox' do
  source url
  type 'pkg'
  checksum lazy{ VirtualboxSource.get_checksum(url) }
end