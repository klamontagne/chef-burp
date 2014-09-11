def whyrun_supported?
  true
end

use_inline_resources

action :create do
  if new_resource.pre_template
    template "/etc/burp/pre.d/#{new_resource.name}" do
      cookbook new_resource.cookbook
      source new_resource.pre_template || 'pre_backup.sh'
      owner 'root'
      group 'root'
      mode 0750 # May be sensitive e.g. passwords
    end
  end
  if new_resource.post_template
    template "/etc/burp/post.d/#{new_resource.name}" do
      cookbook new_resource.cookbook
      source new_resource.post_template || 'post_backup.sh'
      owner 'root'
      group 'root'
      mode 0750 # May be sensitive e.g. passwords
    end
  end
end
