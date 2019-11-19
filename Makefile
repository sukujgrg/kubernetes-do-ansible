.PHONY: destroy
destroy:
	ansible-playbook site.yml -e 'state=absent' -t provision

.PHONY: provision
provision:
	ansible-playbook site.yml -e 'state=present' -t provision
	
.PHONY: create
create: provision
	ansible-playbook site.yml -e 'state=present' -t k8s

.PHONY: common
common: provision
	ansible-playbook site.yml -e 'state=present' -t common

# jp.py is part of jmespath python module
.PHONY: listdroplets
listdroplets:
	./inventory/digital_ocean.py -d -p | jp.py droplets[*].[name,networks.v4[0].ip_address]

.PHONY: ssh
ssh:
	ssh ubuntu@$(shell ./inventory/digital_ocean.py -d -p | jp.py 'droplets[?name == `master01`].networks.v4[0].ip_address | [0]')
