#<
# Add a path to be backed up by the BURP client.
# The path is added to node attributes during
# [compile time](http://docs.getchef.com/essentials_nodes_chef_run.html),
# so the burp::client recipe can be added at any point in your run_list.
#
# Example:
# ```ruby
# burp_include '/var/backups'
# ```
#
#>

define :burp_include do
  i = params[:name]
  ruby_block "add burp include #{i}" do
    block do
      node.default['burp']['includes'][i] = i
    end
    not_if { node['burp']['includes'][i] }
  end.run_action(:run)
end
