def whyrun_supported?
  true
end

use_inline_resources

action :create do
  file "/etc/burp/conf.d/exclude_#{new_resource.name}" do
    if new_resource.regex
      content "exclude_regex = #{new_resource.path}\n"
    else
      content "exclude = #{new_resource.path}\n"
    end
    owner 'root'
    group 'root'
    mode 0640 # May be sensitive e.g. passwords
  end
end

action :delete do
  file "/etc/burp/conf.d/exclude_#{new_resource.name}" do
    action :delete
  end
end
