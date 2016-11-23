
#<
# Install BURP and setup a client configuration with a random password.
# Sets the server to the content of ```node['burp']['server']```.
# Set this attribute in a
# [wrapper cookbook](http://www.getchef.com/blog/2013/12/03/doing-wrapper-cookbooks-right/),
# or in an environment, for example.
#>

include_recipe 'burp::common'

require 'securerandom'
node.set_unless['burp']['password'] = SecureRandom.base64 34

burp_client node['fqdn'] do
  server node['burp']['server'] || '127.0.0.1' # TODO: search for server
  password node['burp']['password']
end

cron 'burp backup start' do
  hour 17
  minute 0
  shell '/bin/bash'
  # Don't stampede the server at 17:00:00
  command 'sleep $(( $RANDOM \% 30)) && /sbin/start burp >/dev/null'
  user 'root'
  action (node.platform_version == '14.04' ? :create : :delete)
end

cron 'burp backup stop' do
  hour 6
  minute 0
  command '/sbin/stop burp >/dev/null 2>/dev/null'
  user 'root'
  action (node.platform_version == '14.04' ? :create : :delete)
end

template '/etc/init/burp.conf' do
  source 'client/upstart.burp.erb'
  owner 'root'
  group 'root'
  mode 0644
  action (node.platform_version == '14.04' ? :create : :delete)
end

template '/etc/systemd/system/burp.service' do
  source 'client/systemd.burp.erb'
  owner 'root'
  group 'root'
  mode 0644
  action (node.platform_version == '16.04' ? :create : :delete)
end
