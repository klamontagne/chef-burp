include_recipe 'burp::common'

%w(
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

