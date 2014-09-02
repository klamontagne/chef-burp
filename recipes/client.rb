include_recipe 'burp::common'

%w(
  conf.d
  pre.d
  post.d
  crypto
).each do |d|
  directory "/etc/burp/#{d}" do
    owner 'root'
    group 'root'
    mode 0750
    recursive true
  end
end

%w(
  pre.sh
  post.sh
).each do |f|
  cookbook_file "/etc/burp/#{f}" do
    source "client/#{f}"
    owner 'root'
    group 'root'
    mode 0755
  end
end

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless['burp']['password'] = secure_password

# burp_client node['fqdn'] do
#   server node['burp']['server'] || '127.0.0.1'
#   password node['burp']['password']
# end

burp_path 'backups' do
  path '/var/backups'
end

burp_exclude 'bundler' do
  path '.*/bundle/.*'
  regex true
end
