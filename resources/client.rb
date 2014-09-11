#<
# Installs the burp client. This is currently only used internally by the
# [burp::client](#burpclient) recipe and not intended to use elsewhere.
#>

actions :create
default_action :create

#<> A name for the client. Usually, the node's FQDN.
attribute :name, kind_of: String, name_attribute: true
#<> The server to connect to.
attribute :server, kind_of: String, required: true
#<> The auto-generated password.
attribute :password, kind_of: String, regex: /[A-Za-z0-9\/\+\=]{8,34}/, required: true
