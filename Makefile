.PHONY: destroy
destroy:
	ansible-playbook site.yml -e 'state=absent' -t provision

.PHONY: provision
provision:
	ansible-playbook site.yml -e 'state=present' -t provision
	
.PHONY: create
create: provision
	ansible-playbook site.yml -e 'state=present' -t k8s
