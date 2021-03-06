#<
# Install BURP and setup a server configuration in /etc/burp-server.
# Searches for clients and installs an individual config file for each one in
# */etc/burp-server/clientconfdir*.
#>

include_recipe 'burp::common'

user 'burp' do
  system true
end

directory '/etc/burp-server' do
  owner 'burp'
  group 'root'
  mode 0750
end

%w(
  notify_script
  timer_script
  summary_script
).each do |s|
  execute "install burp #{s}" do
    cwd "#{Chef::Config[:file_cache_path]}/burp"
    command "install --mode=0755 -o root -g root ./configs/server/#{s} /etc/burp-server/"
    not_if { ::File.exist? "/etc/burp-server/#{s}" }
  end
end

directory '/etc/burp-server/crypto' do
  owner 'burp'
  group 'root'
  mode 0750
end

directory '/etc/burp-server/clientconfdir' do
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

directory '/var/spool/burp' do
  owner 'burp'
  group 'burp'
  mode 0750
end

# Search for clients
# partial_search requires:
# - Chef Server >= 11.0.4
# - Chef Client >= 11.10.0 or the partial_search cookbook
if Chef::Config[:solo] && !node['burp']['chefspec']
  Chef::Log.info('Not searching for clients under chef-solo')
  clients = {}
else
  query =  'recipes:burp\:\:client AND '
  query += "burp_server:#{node['burp']['servername']} "
  if node['burp']['restrict_search_environment']
    query += "AND chef_environment:#{node.chef_environment}"
  end

  clients = partial_search(
    :node,
    query,
    keys: {
      'name' => %w(fqdn),
      'password' => %w(burp password)
    }
  )
end

clients.each do |client|
  file "/etc/burp-server/clientconfdir/#{client['name']}" do
    owner 'burp'
    group 'burp'
    mode 0640
    content "password = #{client['password']}\ndedup_group = #{client['name']}"
  end
end

service 'burp-server' do
  provider Chef::Provider::Service::Upstart
  supports status: true, restart: true, reload: false
  action :start
end
