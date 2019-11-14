## Deploy a Kubernetes cluster on Digital Ocean with Kubeadm
Ansible playbook for deploying a Kubernetes cluster with kubeadm on Digital Ocean droplets.

### Purpose
Spin up quickly a kuberntes cluster on Digital Ocean.

I find it useful when you don't have a good local machine and internet around where you can spin up few vagrant boxes.
This ansible playbook will [create](#deploy) two Droplets and deploy a kubernetes cluster on it. The creation of two droplets will incur [charges](https://www.digitalocean.com/pricing/). So when you don't need it [destroy](#destroy-droplets-and-thus-kubernetes-cluster) it.

### Environment Prep
- Generate Digital Ocean API [token](https://cloud.digitalocean.com/account/api/tokens) and keep it secure.
- Add [SSH Key](https://cloud.digitalocean.com/account/security) to your Digital Ocean account.
- Update [ansible.cfg](ansible.cfg) with the path of your SSH private key on your working machine.
- `python3 -m pip install ansible>=2.8 --user`
- `python3 -m pip install jmespath --user`

### Deploy
```
$ export DO_API_TOKEN=<YOUR DIGITAL OCEAN API TOKEN>
$ make create
```
If you run `make create` second time, it will perform `kubeadm reset -f` and then bootstrap kubernetes cluster from scratch again.

### Destroy Droplets and thus kubernetes cluster
```
$ export DO_API_TOKEN=<YOUR DIGITAL OCEAN API TOKEN>
$ make destroy
```

### Droplet Region and Droplet Size

If you want change Droplet Region and Droplet Size, modify it in [group_vars/all.yml](group_vars/all.yml)

### Check cluster after the deployment
Note: SSHing with `root` user is a terrible idea. So always make sure to [destroy](#destroy-droplets-and-thus-kubernetes-cluster) the droplets when you don't need it. 

```
suku@localhost:~$ ssh ubuntu@<MASTER IP ADDRESS> -i ~/.ssh/<your private key>
...
...

ubuntu@master01:~$ kubectl get nodes
NAME       STATUS   ROLES    AGE   VERSION
master01   Ready    master   15m   v1.15.5
worker01   Ready    <none>   14m   v1.15.5

ubuntu@master01:~$ kubectl get cs
NAME                 STATUS    MESSAGE             ERROR
controller-manager   Healthy   ok
scheduler            Healthy   ok
etcd-0               Healthy   {"health":"true"}
```
