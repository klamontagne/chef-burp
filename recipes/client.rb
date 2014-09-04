include_recipe 'burp::common'

require 'securerandom'
node.set_unless['burp']['password'] = SecureRandom.base64 34

burp_client node['fqdn'] do
  server node['burp']['server'] || '127.0.0.1' # TODO: search for server
  password node['burp']['password']
end
