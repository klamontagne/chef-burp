
#<
# Retrieve burp [from Github](https://github.com/grke/burp), compile and install the binaries.
# Also installs build dependencies
# *librsync-dev*,
# *libz-dev*,
# *libssl-dev*,
# *uthash-dev*.
#>

include_recipe 'apt'
include_recipe 'build-essential'
include_recipe 'git'

package 'librsync-dev'
package 'libz-dev'
package 'libssl-dev'
package 'uthash-dev'

git 'burp' do
  destination "#{Chef::Config[:file_cache_path]}/burp"
  repository 'https://github.com/grke/burp.git'
  reference '1e8eebac420f2b0dc29102602b7e5e437d58d5b7' # 1.4.40
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
