actions :create
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :cookbook, kind_of: String, required: true
attribute :pre_template, kind_of: String, default: 'pre_backup.sh'
attribute :post_template, kind_of: String, default: 'post_backup.sh'
