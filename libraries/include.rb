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

def burp_include(path)
  node.default['burp']['includes'][path] = path
  Chef::Log.info("Adding burp_include #{path}")
end
