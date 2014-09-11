# Let chefspec be able to create a stub burp_client
if defined?(ChefSpec)
  ChefSpec::Runner.define_runner_method(:create_burp_client)

  def create_burp_client(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:burp_client, :create, resource)
  end

  def create_burp_plugin(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:burp_plugin, :create, resource)
  end

end
