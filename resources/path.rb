actions :create, :delete
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :path, kind_of: String, required: true, regex: [/^\//]
