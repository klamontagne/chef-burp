
include_recipe 'apt'
include_recipe 'build-essential'

package 'librsync-dev'
package 'libz-dev'
package 'libssl-dev'
package 'uthash-dev'

git 'burp' do
  destination "#{Chef::Config[:file_cache_path]}/burp"
  repository 'https://github.com/grke/burp.git'
  reference '72f2ddf352f80ac45215b4dc9e18c8b61970bd8e'
  user 'root'
  group 'root'
  action :checkout
end

execute 'build burp' do
  cwd "#{Chef::Config[:file_cache_path]}/burp"
  command './configure --disable-ipv6 && make'
  action :nothing
  subscribes :run, 'git[burp]', :immediate
end

execute 'install burp' do
  cwd "#{Chef::Config[:file_cache_path]}/burp"
  command 'install ./src/burp ./configs/certs/CA/burp_ca /usr/sbin/'
  action :nothing
  subscribes :run, 'execute[build burp]', :immediate
end
