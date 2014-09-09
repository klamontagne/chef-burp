require 'chefspec'
require 'chefspec/berkshelf'

describe 'burp::common' do
  let(:chef_run) do
    runner = ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04')
    runner.converge(described_recipe)
  end

  it 'should include dependencies' do
    expect(chef_run).to include_recipe('git::default')
    expect(chef_run).to include_recipe('apt::default')
    expect(chef_run).to include_recipe('build-essential::default')
  end

  it 'checkouts burp git' do
    expect(chef_run).to checkout_git('burp')
  end

  it 'builds & installs burp after git checkout' do
    expect(chef_run).to_not run_execute('install burp')
    expect(chef_run.execute('install burp')).to subscribe_to('execute[build burp]').on(:run)
    expect(chef_run.execute('build burp')).to subscribe_to('git[burp]').on(:run)
  end
end
