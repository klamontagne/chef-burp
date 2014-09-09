require 'chefspec'
require 'chefspec/berkshelf'

describe 'burp::server' do

  it 'creates a proper client config in clientconfdir/' do
    Chef::Recipe.any_instance.stub(:partial_search).with(
        :node, 'recipes:burp\:\:client AND burp_server:myserver.example.com ',
        keys: { 'name' => %w(fqdn), 'password' => %w(burp password) }
      ).and_return(
        [{ 'name' => 'example.com', 'password' => 'abcdefgh' }]
      )
    runner = ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04')
    runner.node.set['burp']['chefspec'] = true
    runner.node.automatic['fqdn'] = 'myserver.example.com'
    runner.converge(described_recipe)
    expect(runner).to render_file('/etc/init/burp-server.conf')
    expect(runner).to render_file('/etc/burp-server/clientconfdir/example.com').with_content('password = abcdefgh')
    expect(runner).to render_file('/etc/burp-server/clientconfdir/example.com').with_content('dedup_group = example.com')
  end

end
