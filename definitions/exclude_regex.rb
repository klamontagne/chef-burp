define :burp_exclude_regex do
  er = params[:name]
  ruby_block "add burp exclude_regex #{er}" do
    block do
      node.default['burp']['excludes_regex'][er] = er
    end
    not_if { node['burp']['excludes_regex'][er] }
  end.run_action(:run)
end
