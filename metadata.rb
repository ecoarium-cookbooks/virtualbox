name             "virtualbox"
maintainer       "jay flowers"
maintainer_email "jay.flowers@gmail.com"
license          "Apache 2.0"
description      "Installs virtualbox"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.8.11"

%w{mac_os_x windows}.each do |os|
  supports os
end

depends "dmg"
depends "windows"
