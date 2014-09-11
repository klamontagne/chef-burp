require 'chefspec'
require 'chefspec/berkshelf'

describe 'burp::_test' do
  let(:chef_run) do
    runner = ChefSpec::Runner.new(step_into: ['burp_plugin'], platform: 'ubuntu', version: '12.04')
    runner.converge(described_recipe)
  end

  it 'runs the plugin LWRP' do
    expect(chef_run).to create_burp_plugin('specplugin')
    expect(chef_run).to create_burp_plugin('nilplugin')
  end

  it 'creates plugin scripts' do
    expect(chef_run).to create_template('/etc/burp/pre.d/specplugin').with(mode: 0750)
    expect(chef_run).to create_template('/etc/burp/post.d/specplugin').with(mode: 0750)
  end

  it 'does not create plugin scripts' do
    expect(chef_run).not_to create_template('/etc/burp/pre.d/nilplugin')
    expect(chef_run).not_to create_template('/etc/burp/post.d/nilplugin')
  end

end
