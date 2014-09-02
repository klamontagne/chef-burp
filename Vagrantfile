# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'
Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = 'burp-berkshelf'
  config.omnibus.chef_version = :latest
  config.vm.box = 'chef/ubuntu-12.04'
  # config.vm.box_url = "https://vagrantcloud.com/chef/ubuntu-14.04/version/1/provider/virtualbox.box"
  config.vm.network 'private_network', ip: '192.168.50.21'
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.log_level = :info
    chef.json = { }

    chef.run_list = [
      'recipe[apt]',
      'recipe[build-essential]',
      'recipe[burp::_test]'
    ]
  end
end
