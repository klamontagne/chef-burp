
include_recipe 'burp::server'
include_recipe 'burp::common'

file '/etc/burp-server/clientconfdir/testclient' do
  content 'password = abcdefgh'
  owner 'burp'
  group 'burp'
  mode 0640
end

burp_client 'testclient' do
  server '127.0.0.1'
  password 'abcdefgh'
end

burp_include '/var/backups'
burp_exclude '/var/nobackups'
burp_exclude_regex '.*/bundle/.*'

file '/var/backups/hello' do
  content 'hello'
end

execute 'test burp client' do
  # Give a little time for the server to start
  command 'sleep 10 && /usr/sbin/burp -a l -c /etc/burp/burp.conf'
  action :run
end

cron 'burp backup start' do
  hour 17
  minute 0
  command '/sbin/start burp'
  user 'root'
end

cron 'burp backup stop' do
  hour 6
  minute 0
  command '/sbin/stop burp'
  user 'root'
end

template '/etc/init/burp.conf' do
  source 'client/upstart.burp.erb'
  owner 'root'
  group 'root'
  mode 0644
end

burp_plugin 'specplugin' do
  cookbook 'burp'
  pre_template 'client/test_script.erb'
  post_template 'client/test_script.erb'
end

burp_plugin 'nilplugin' do
  cookbook 'burp'
  pre_template nil
  post_template nil
end
