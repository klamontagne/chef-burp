
include_recipe 'burp::server'
include_recipe 'burp::client'

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

execute 'test burp client' do
  command '/usr/sbin/burp -a l -c /etc/burp/burp.conf'
  action :run
end

file '/var/backups/hello' do
  content 'hello'
end
