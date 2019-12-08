## Deploy a Kubernetes cluster on Digital Ocean with Kubeadm
Ansible playbook for deploying a Kubernetes cluster with kubeadm on Digital Ocean droplets.

### Cluster Details
- kubernetes 1.16.*
- docker 18.06.*
- ubuntu-18.04

### Purpose
Spin up quickly a kuberntes cluster on Digital Ocean.

I find it useful when you don't have a good local machine and internet around where you can spin up few vagrant boxes.
This ansible playbook will [create](#deploy) two Droplets and deploy a kubernetes cluster on it.
The creation of droplets will incur [charges](https://www.digitalocean.com/pricing/).
So when you don't need it [destroy](#destroy-droplets-and-thus-kubernetes-cluster) it.

### Environment Prep
- Generate Digital Ocean API [token](https://cloud.digitalocean.com/account/api/tokens) and keep it secure.
- Add [SSH Key](https://cloud.digitalocean.com/account/security) to your Digital Ocean account.
- Update [ansible.cfg](ansible.cfg) with the path of your SSH private key on your working machine.
- `python3 -m pip install --user -r requirements.txt`

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

Droplet Region and Droplet Size can be modified by changing `DO_REGION_ID` and `DO_SIZE_ID` respectively in [group_vars/all.yml](group_vars/all.yml)

### Number of worker nodes

You can add more worker nodes by updating `K8S_NODES` var in [group_vars/all.yml](group_vars/all.yml)

### Check cluster after the deployment

`make ssh` will take you into the master node if you have configured your local `ssh-agent` or `~/.ssh/config` with appropriate `ssh-key` (`IdentityFile`).

```
$ export DO_API_TOKEN=<YOUR DIGITAL OCEAN API TOKEN>
$ make ssh # add your ssh key to ssh-agent or specify the ssh key in ~/.ssh/config
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

### Get all currently running provisioned nodes

`make listdroplets` will list all the running instances in your DigitalOcean account.

```
$ export DO_API_TOKEN=<YOUR DIGITAL OCEAN API TOKEN>
$ make listdroplets
./inventory/digital_ocean.py -d -p | jp.py droplets[*].[name,networks.v4[0].ip_address]
[
    [
        "master01",
        "xx.xx.xx.xx"
    ],
    [
        "worker01",
        "xx.xx.x.xx"
    ]
]
```

