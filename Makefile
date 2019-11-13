.PHONY: destroy
destroy:
	ansible-playbook site.yml -e 'state=absent' -t provision
.PHONY: create
create:
	ansible-playbook site.yml -e 'state=present' -t provision,k8s
