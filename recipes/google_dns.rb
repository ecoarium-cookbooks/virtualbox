#
# Cookbook Name:: virtualbox::google_dns
# Recipe:: default
#

file "/etc/resolv.conf" do
  content IO.read(File.dirname(__FILE__) + '/../files/default/resolv.conf')
end.run_action(:create)