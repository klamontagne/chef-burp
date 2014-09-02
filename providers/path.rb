def whyrun_supported?
  true
end

use_inline_resources

action :create do
  file "/etc/burp/conf.d/#{new_resource.name}" do
    content "include = #{new_resource.path}\n"
    owner 'root'
    group 'root'
    mode 0640 # May be sensitive e.g. passwords
  end
end

action :delete do
  file "/etc/burp/conf.d/#{new_resource.name}" do
    action :delete
  end
end
