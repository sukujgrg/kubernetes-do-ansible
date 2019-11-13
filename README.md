## Deploy a Kubernetes cluster on Digital Ocean with Kubeadm

Ansible playbook for deploying a Kubernetes cluster with kubeadm on Digital Ocean droplets.

### Environment Prep
- Digital Ocean API token
- Add an [SSH Key](https://cloud.digitalocean.com/account/security) to your Digital Ocean account.
- Update [ansible.cfg](ansible.cfg) with the path of your SSH private key on your working machine.
- `python3 -m pip install ansible>=2.8 --user`
- `python3 -m pip install jmespath --user`

### Deploy
```
$ export DO_API_TOKEN=<YOUR DIGITAL OCEAN API TOKEN>
$ make create
```

### Destroy Droplets and thus kubernetes cluster
```
$ make destroy
```
