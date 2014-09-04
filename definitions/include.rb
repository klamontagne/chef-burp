define :burp_include do
  i = params[:name]
  ruby_block "add burp include #{i}" do
    block do
      node.default['burp']['includes'][i] = i
    end
    not_if { node['burp']['includes'][i] }
  end.run_action(:run)
end
