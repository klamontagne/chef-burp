require 'chefspec'
require 'chefspec/berkshelf'

describe 'burp::client' do
  let(:chef_run) do
    runner = ChefSpec::Runner.new(step_into: ['burp_client'], platform: 'ubuntu', version: '12.04')
    runner.node.automatic['fqdn'] = 'example.com'
    runner.node.set[:burp][:password] = 'PfthgMdRVLOKiuXO/92GDNxxAr0GvrWI6TaYakvTu+Uovw=='
    runner.node.set[:burp][:server] = 'myserver.example.com'
    runner.node.set[:burp][:includes] = { '1' => '/myinclude1', '2' => '/myinclude2' }
    runner.node.set[:burp][:excludes] = { '1' => '/myexclude1', '2' => '/myexclude2' }
    runner.node.set[:burp][:excludes_regex] = { '1' => '/myexcluderegex1', '2' => '/myexcluderegex2' }
    runner.converge(described_recipe)
  end

  it 'includes common recipe' do
    expect(chef_run).to include_recipe('burp::common')
  end

  it 'creates a burp client' do
    # Password is validated by the burp_client resource at runtime
    expect(chef_run).to create_burp_client('example.com')
  end

  def c(content)
    expect(chef_run).to render_file('/etc/burp/burp.conf').with_content(content)
  end

  it 'creates a config' do
    c 'password = PfthgMdRVLOKiuXO/92GDNxxAr0GvrWI6TaYakvTu+Uovw=='
    c 'cname = example.com'
    c 'server = myserver.example.com'
  end

  it 'add includes' do
    c 'include = /myinclude1'
    c 'include = /myinclude2'
  end

  it 'add excludes' do
    c 'exclude = /myexclude1'
    c 'exclude = /myexclude2'
  end

  it 'add excludes_regex' do
    c 'exclude_regex = /myexcluderegex1'
    c 'exclude_regex = /myexcluderegex2'
  end

end
