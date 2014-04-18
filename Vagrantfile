# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian-7.4.0-amd64_virtualbox"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://vagrantcloud.com/ffuenf/debian-7.4.0-amd64/version/5/provider/virtualbox.box"

  config.vm.define "zk1" do |zk1|
    zk1.vm.network :private_network, ip: "192.168.10.20"
    zk1.vm.hostname = "zk1"
    zk1.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
    end
    zk1.vm.provision "shell", path: "vagrant/java7.sh"
    zk1.vm.provision "shell", path: "vagrant/zk.sh"
    zk1.vm.provision "shell", path: "vagrant/vim.sh"
  end

  config.vm.define "k1" do |k1|
    k1.vm.network :private_network, ip: "192.168.10.21"
    k1.vm.hostname = "k1"
    k1.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end
    k1.vm.provision "shell", path: "vagrant/java7.sh"
    k1.vm.provision "shell", path: "vagrant/broker.sh", :args => "1"
    k1.vm.provision "shell", path: "vagrant/vim.sh"
  end
end
