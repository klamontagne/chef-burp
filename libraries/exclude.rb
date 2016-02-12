#<
# Add a path to be excluded by the BURP client.
# The path is added to node attributes during
# [compile time](http://docs.getchef.com/essentials_nodes_chef_run.html),
# so the burp::client recipe can be added at any point in your run_list.
#
# Example:
# ```ruby
# burp_exclude '/var/lib/mysoftware/cache'
# ```
#
#>

def burp_exclude(path)
  node.default['burp']['exclude'][path] = path
  Chef::Log.info("Adding burp_exclude #{path}")
end
