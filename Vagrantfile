# https://github.com/hashicorp/vagrant/issues/9893
# https://michele.sciabarra.com/2018/02/12/devops/Kubernetes-with-KubeAdm-Ansible-Vagrant/

IMAGE_NAME = "generic/ubuntu1604"

# use two digits id below, please
nodes = [
  { :hostname => 'master01',  :ip => '10.0.0.10', :id => '10', :group => 'master', :cpu => 3},
  { :hostname => 'node01',   :ip => '10.0.0.11', :id => '11', :group => 'worker', :cpu => 1},
]

groups = {
  'master' => ['master01'],
  'worker' => nodes.select{|n| n[:group] == 'worker'}.map{|n| n[:hostname]}
}

Vagrant.configure("2") do |config|
    # Turn off shared folders
    config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true

    nodes.each do |node|
        config.vm.define node[:hostname] do |node_config|
            node_config.vm.box_check_update = false
            node_config.vm.box = IMAGE_NAME
            node_config.vm.network "private_network", ip: node[:ip]
            node_config.vm.hostname = node[:hostname]
            node_config.vm.provider "libvirt" do |v|
                v.memory = 2048
                v.cpus = node[:cpu]
            end
            node_config.vm.provision "bootstrap", type: "ansible" do |ansible|
                ansible.verbose = "vv"
                ansible.playbook = "site.yml"
                ansible.groups = groups
                ansible.compatibility_mode = "2.0"
                ansible.extra_vars = {
                }
            end

            #node_config.vm.provision "shell", path: "vagrant_scripts/base.sh"

        end
    end
end
