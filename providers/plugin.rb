def whyrun_supported?
  true
end

use_inline_resources

action :create do
  template "/etc/burp/pre.d/#{new_resource.name}" do
    cookbook new_resource.cookbook
    source new_resource.pre_template
    owner 'root'
    group 'root'
    mode 0750 # May be sensitive e.g. passwords
  end
  template "/etc/burp/pre.d/#{new_resource.name}" do
    cookbook new_resource.cookbook
    source new_resource.pre_template
    owner 'root'
    group 'root'
    mode 0750 # May be sensitive e.g. passwords
  end
end

action :delete do
  file "/etc/burp/pre.d/#{new_resource.name}" do
    action :delete
  end
  file "/etc/burp/post.d/#{new_resource.name}" do
    action :delete
  end
end
