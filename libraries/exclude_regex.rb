#<
# Add a regex to be excluded by the BURP client.
# The regex is added to node attributes during
# [compile time](http://docs.getchef.com/essentials_nodes_chef_run.html),
# so the burp::client recipe can be added at any point in your run_list.
# See the [man page](http://burp.grke.org/docs/manpage.html) for the
# exclude_regex configuration item.
#
# Example:
# ```ruby
# burp_exclude_regex '.*/bundle/.*'
# burp_exclude_regex '.*/cache/.*'
# ```
#
#>

def burp_exclude_regex(path)
  node.default['burp']['exclude_regexegex'][path] = path
  Chef::Log.info("Adding burp_exclude_regex #{path}")
end
