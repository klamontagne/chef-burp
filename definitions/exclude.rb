define :burp_exclude do
  e = params[:name]
  ruby_block "add burp exclude #{e}" do
    block do
      node.default['burp']['excludes'][e] = e
    end
    not_if { node['burp']['excludes'][e] }
  end.run_action(:run)
end
