# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Define the first machine
  config.vm.define "server1" do |server1|
    server1.vm.box = "generic/oracle8"
    server1.vm.hostname = "server1"
    server1.vm.network "private_network", type: "dhcp"
    server1.vm.network "private_network", auto_config: false, virtualbox__intnet: "Lekce9", :adapter => 2
  end

  # Define the second machine
  config.vm.define "server2" do |server2|
    server2.vm.box = "generic/oracle8"
    server2.vm.hostname = "server2"
    server2.vm.network "private_network", type: "dhcp"
    server2.vm.network "private_network", auto_config: false, virtualbox__intnet: "Lekce9", :adapter => 2
  end

end