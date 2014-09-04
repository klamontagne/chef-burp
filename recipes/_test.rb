
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
  command '/usr/sbin/burp -a l -c /etc/burp/burp.conf'
  action :run
end

