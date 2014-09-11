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

define :burp_exclude do
  e = params[:name]
  ruby_block "add burp exclude #{e}" do
    block do
      node.default['burp']['excludes'][e] = e
    end
    not_if { node['burp']['excludes'][e] }
  end.run_action(:run)
end
