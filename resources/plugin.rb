actions :create
default_action :create

attribute :name, kind_of: String, name_attribute: true, regex: /^[a-zA-Z0-9_-]+$/
attribute :cookbook, kind_of: String, required: true
attribute :pre_template, kind_of: [String, NilClass], default: 'pre_backup.sh'
attribute :post_template, kind_of: [String, NilClass], default: 'post_backup.sh'
