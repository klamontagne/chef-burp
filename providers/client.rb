def whyrun_supported?
  true
end

use_inline_resources

action :create do

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

  template '/etc/burp/burp.conf' do
    source 'client/burp.conf.erb'
    owner 'root'
    group 'root'
    variables lazy {
      {
        cname: new_resource.name,
        server: new_resource.server,
        password: new_resource.password,
        config: node['burp']['client']['config'],
        includes: node['burp']['includes'],
        excludes: node['burp']['excludes'],
        excludes_regex: node['burp']['excludes_regex']
      }
    }
    mode 0644
  end
end
