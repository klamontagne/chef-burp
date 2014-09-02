actions :create, :delete
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :path, kind_of: String, required: true
attribute :regex, kind_of: [TrueClass, FalseClass], default: false
