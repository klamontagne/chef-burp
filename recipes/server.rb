include_recipe 'burp::common'

user 'burp' do
  system true
end

directory '/etc/burp-server' do
  owner 'burp'
  group 'root'
  mode 0750
end

directory '/etc/burp-server/crypto' do
  owner 'burp'
  group 'root'
  mode 0750
end

template '/etc/burp-server/crypto/CA.cnf' do
  source 'server/CA.cnf.erb'
  owner 'burp'
  group 'root'
  mode 0640
end

template '/etc/burp-server/burp.conf' do
  source 'server/burp-server.conf.erb'
  owner 'burp'
  group 'root'
  mode 0640
end

template '/etc/init/burp-server.conf' do
  source 'server/upstart.burp-server.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
end

directory '/run/burp' do
  owner 'burp'
  group 'root'
  mode 0775
end

directory '/var/spool/burp' do
  owner 'burp'
  group 'burp'
  mode 0750
end

execute 'generate burp server certificates' do
  cwd '/etc/burp-server'
  user 'burp'
  group 'burp'
  command '/usr/sbin/burp -F -c /etc/burp-server/burp.conf -g'
  not_if { File.exist? '/etc/burp-server/crypto/CA/burpserver.key' }
end

service 'burp-server' do
  provider Chef::Provider::Service::Upstart
  supports status: true, restart: true, reload: false
  action :start
end
