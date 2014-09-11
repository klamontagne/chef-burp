#<
# Copies a pair of scripts from a Chef template resource to be used as actions
# before/after a backup runs.
#
# Examples:
#
# ```ruby
# burp_plugin 'cassandra' do
#   cookbook 'mycompany-cassandra'
#   pre_template 'scripts/snapshot.sh'
#   post_template 'clear snapshot'
# end
#
# burp_plugin 'mysql' do
#   cookbook 'mycompany-mysql'
#   pre_template 'dump.sh'
#   post_template nil
# end
# ```
#
#>

actions :create
default_action :create

#<
# A name for the plugin. Be creative and avoid duplicates.
# ex.: ```mycompany_mysql_backup```
# Only accepts valid Debian cron script names (```^[a-zA-Z0-9_-]+$```)
#>
attribute :name, kind_of: String, name_attribute: true, regex: /^[a-zA-Z0-9_-]+$/
#<
# The cookbook in which to find the templates.
#>
attribute :cookbook, kind_of: String, required: true
#<
# The script to run before starting to backup files. if it exits with a non-zero
# status, the backup is interrupted. Can be ```nil``` if no script is to be
# installed.
#>
attribute :pre_template, kind_of: [String, NilClass]
#<
# The script to run after the backup completes. If it exits with a non-zero
# status, the other plugins **will still run**. Can be ```nil``` if no script is
# to be installed.
#>
attribute :post_template, kind_of: [String, NilClass]
