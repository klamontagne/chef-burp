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

define :burp_exclude_regex do
  er = params[:name]
  ruby_block "add burp exclude_regex #{er}" do
    block do
      node.default['burp']['excludes_regex'][er] = er
    end
    not_if { node['burp']['excludes_regex'][er] }
  end.run_action(:run)
end
