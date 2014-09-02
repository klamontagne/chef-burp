actions :create
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :server, kind_of: String, required: true
attribute :password, kind_of: String, regex: /[A-Za-z0-9_-]{8,34}/, required: true
attribute :includes, kind_of: [Array, NilClass], default: ['/var/backups']
