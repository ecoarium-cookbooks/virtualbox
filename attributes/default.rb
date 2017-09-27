#
# Cookbook Name:: virtualbox
# Attributes:: default
#

default[:virtualbox][:base_url] = 'http://download.virtualbox.org/virtualbox'
default[:virtualbox][:version] = '4.3.8-92456'
default[:virtualbox][:osx][:file_extension] = 'OSX.dmg'
default[:virtualbox][:windows][:file_extension] = 'Win.exe'
