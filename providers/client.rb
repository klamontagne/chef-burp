def whyrun_supported?
  true
end

use_inline_resources

action :create do
  t = template '/etc/burp/burp.conf' do
    source 'client/burp.conf.erb'
    owner 'root'
    group 'root'
    variables(
      cname: new_resource.name,
      server: new_resource.server,
      password: new_resource.password,
      includes: new_resource.includes
    )
    mode 0644
  end
  new_resource.updated_by_last_action(t.updated_by_last_action?)
end

# def test()
#   # some Ruby code
# end
