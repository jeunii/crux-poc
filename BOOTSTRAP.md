# Bootstrap Guide

The guide explains all the steps needs too deploy the infrastructure in GCP

## Prerequisites

## Tools

Make sure you have the following tools installed locally

* kubectl
* kubectx
* gcloud
* terraform

## GCP setup

Organization ID is `597925389594`. This is the organization under which the entire PoC will be deployed. Run `gcloud init` to initialize the GCP local env.

### Authenticate to GCP

Run the following command to authenticate as your user to GCP

```
gcloud auth login
```
Once successful, you should be able to run `gcloud` commands against your setup

## Terraform setup

We will be using the Free tier Terraform cloud to deploy terraform code. Create a free account by logging in [here](https://app.terraform.io/)

Once done, create a new organization called `cruxocm-ai`

## Deploy

Before you can deploy anything on GCP using Terraform cloud, you will need to authorize it first. On your CLI, run the below command

```
gcloud auth application-default login
cat ~/.config/gcloud/application_default_credentials.json | tr -s '\n' ' ' | pbcopy
```

In terraform cloud, goto organization [settings](https://app.terraform.io/app/cruxocm-ai/settings/varsets), create a new Variable Set. Give it a name, set the scope to `Apply Globally` and Add Variable. Set key to `GOOGLE_CREDENTIALS` and value to the output of the above command

Make sure you are using Terraform version `1.5.7` for all workspaces !

### 01_folders

In this step, we will

* Create `crux-poc` root folder under the `cruxocm.ai` organization
* Create `gcp` and `on-prem` folders under `crux-poc` folder

In terraform cloud, create a new Workspace and configure it accordingly

| Key                         | Value                                                  |
|-----------------------------|--------------------------------------------------------|
| Workflow                    | Version Control Workflow                               |
| Version Control Provider    | Github                                                 |
| Repository                  | ``                                                     |
| Workspace Name              | 01_folders                                             |
| Project                     | Default                                                |
| Terraform Working Directory | 01_folders                                             |
| Apply Method                | Manual                                                 |
| VCS Triggers                | Only trigger runs when files in specified paths change |
| Select Syntax               | Prefixes                                               |
| VCS branch                  | build                                                  |

Click on create workspace. Once created, click on New Run and choose run type Plan and apply. This will first plan the deployment and then prompt to apply the changes. Once you have verified the plan, click on on Apply

### 02_project_net-gcp

In this step, we will

* Create the net GCP project

In terraform cloud, create a new Workspace and configure it accordingly

| Key                         | Value                                                  |
|-----------------------------|--------------------------------------------------------|
| Workflow                    | Version Control Workflow                               |
| Version Control Provider    | Github                                                 |
| Repository                  | ``                                                     |
| Workspace Name              | 02_project_net-gcp                                     |
| Project                     | Default                                                |
| Terraform Working Directory | 02_project_net/gcp                                     |
| Apply Method                | Manual                                                 |
| VCS Triggers                | Only trigger runs when files in specified paths change |
| Select Syntax               | Prefixes                                               |
| VCS branch                  | build                                                  |

Click on create workspace. Once created, click on New Run and choose run type Plan and apply. This will first plan the deployment and then prompt to apply the changes. Once you have verified the plan, click on on Apply

### 02_project_net-on-prem

In this step, we will

* Create the net on-prem project

In terraform cloud, create a new Workspace and configure it accordingly

| Key                         | Value                                                  |
|-----------------------------|--------------------------------------------------------|
| Workflow                    | Version Control Workflow                               |
| Version Control Provider    | Github                                                 |
| Repository                  | ``                                                     |
| Workspace Name              | 02_project_net-on-prem                                 |
| Project                     | Default                                                |
| Terraform Working Directory | 02_project_net/on-prem                                 |
| Apply Method                | Manual                                                 |
| VCS Triggers                | Only trigger runs when files in specified paths change |
| Select Syntax               | Prefixes                                               |
| VCS branch                  | build                                                  |

Click on create workspace. Once created, click on New Run and choose run type Plan and apply. This will first plan the deployment and then prompt to apply the changes. Once you have verified the plan, click on on Apply

### 03_network-gcp

In this step, we will

* Create the Shared VPC in the net GCP project

In terraform cloud, create a new Workspace and configure it accordingly

| Key                         | Value                                                  |
|-----------------------------|--------------------------------------------------------|
| Workflow                    | Version Control Workflow                               |
| Version Control Provider    | Github                                                 |
| Repository                  | ``                                                     |
| Workspace Name              | 03_network-gcp                                         |
| Project                     | Default                                                |
| Terraform Working Directory | 03_network/gcp                                         |
| Apply Method                | Manual                                                 |
| VCS Triggers                | Only trigger runs when files in specified paths change |
| Select Syntax               | Prefixes                                               |
| VCS branch                  | build                                                  |

Click on create workspace. Once created, click on New Run and choose run type Plan and apply. This will first plan the deployment and then prompt to apply the changes. Once you have verified the plan, click on on Apply

### 03_network-on-prem

In this step, we will

* Create the Shared VPC in the net on-prem project

In terraform cloud, create a new Workspace and configure it accordingly

| Key                         | Value                                                  |
|-----------------------------|--------------------------------------------------------|
| Workflow                    | Version Control Workflow                               |
| Version Control Provider    | Github                                                 |
| Repository                  | ``                                                     |
| Workspace Name              | 03_network-on-prem                                     |
| Project                     | Default                                                |
| Terraform Working Directory | 03_network/on-prem                                     |
| Apply Method                | Manual                                                 |
| VCS Triggers                | Only trigger runs when files in specified paths change |
| Select Syntax               | Prefixes                                               |
| VCS branch                  | build                                                  |

Click on create workspace. Once created, click on New Run and choose run type Plan and apply. This will first plan the deployment and then prompt to apply the changes. Once you have verified the plan, click on on Apply

### 04_network-vpn

In this step, we will

* Create the HA Cloud VPN setup between the GCP and On-prem VPCs

In terraform cloud, create a new Workspace and configure it accordingly

| Key                         | Value                                                  |
|-----------------------------|--------------------------------------------------------|
| Workflow                    | Version Control Workflow                               |
| Version Control Provider    | Github                                                 |
| Repository                  | ``                                                     |
| Workspace Name              | 04_network-vpn                                         |
| Project                     | Default                                                |
| Terraform Working Directory | 04_network-vpn                                         |
| Apply Method                | Manual                                                 |
| VCS Triggers                | Only trigger runs when files in specified paths change |
| Select Syntax               | Prefixes                                               |
| VCS branch                  | build                                                  |

Click on create workspace. Once created, click on New Run and choose run type Plan and apply. This will first plan the deployment and then prompt to apply the changes. Once you have verified the plan, click on on Apply


### 04_svc_project-gcp

In this step, we will

* Create the services project in GCP folder

In terraform cloud, create a new Workspace and configure it accordingly

| Key                         | Value                                                  |
|-----------------------------|--------------------------------------------------------|
| Workflow                    | Version Control Workflow                               |
| Version Control Provider    | Github                                                 |
| Repository                  | ``                                                     |
| Workspace Name              | 04_svc_project-gcp                                     |
| Project                     | Default                                                |
| Terraform Working Directory | 04_project_svc/gcp                                     |
| Apply Method                | Manual                                                 |
| VCS Triggers                | Only trigger runs when files in specified paths change |
| Select Syntax               | Prefixes                                               |
| VCS branch                  | build                                                  |

Click on create workspace. Once created, click on New Run and choose run type Plan and apply. This will first plan the deployment and then prompt to apply the changes. Once you have verified the plan, click on on Apply

### 04_svc_project-on-prem

In this step, we will

* Create the services project in on-prem folder

In terraform cloud, create a new Workspace and configure it accordingly

| Key                         | Value                                                  |
|-----------------------------|--------------------------------------------------------|
| Workflow                    | Version Control Workflow                               |
| Version Control Provider    | Github                                                 |
| Repository                  | ``                                                     |
| Workspace Name              | 04_svc_project-on                                      |
| Project                     | Default                                                |
| Terraform Working Directory | 04_project_svc/on-prem                                 |
| Apply Method                | Manual                                                 |
| VCS Triggers                | Only trigger runs when files in specified paths change |
| Select Syntax               | Prefixes                                               |
| VCS branch                  | build                                                  |

Click on create workspace. Once created, click on New Run and choose run type Plan and apply. This will first plan the deployment and then prompt to apply the changes. Once you have verified the plan, click on on Apply

### 05_k8s-gcp

In this step, we will

* Create and configure a GKE cluster

In terraform cloud, create a new Workspace and configure it accordingly

| Key                         | Value                                                  |
|-----------------------------|--------------------------------------------------------|
| Workflow                    | Version Control Workflow                               |
| Version Control Provider    | Github                                                 |
| Repository                  | ``                                                     |
| Workspace Name              | 05_k8s-gcp                                             |
| Project                     | Default                                                |
| Terraform Working Directory | 05_k8s/gcp                                |
| Apply Method                | Manual                                                 |
| VCS Triggers                | Only trigger runs when files in specified paths change |
| Select Syntax               | Prefixes                                               |
| VCS branch                  | build                                                  |

Click on create workspace. Once created, click on New Run and choose run type Plan and apply. This will first plan the deployment and then prompt to apply the changes. Once you have verified the plan, click on on Apply

### 05_k8s-gcp

In this step, we will

* Create and configure a GKE cluster
* Create and configure the default node pool
* Label the cluster to be included in the mesh

In terraform cloud, create a new Workspace and configure it accordingly

| Key                         | Value                                                  |
|-----------------------------|--------------------------------------------------------|
| Workflow                    | Version Control Workflow                               |
| Version Control Provider    | Github                                                 |
| Repository                  | ``                                                     |
| Workspace Name              | 05_k8s-gcp                                             |
| Project                     | Default                                                |
| Terraform Working Directory | 05_k8s/gcp                                |
| Apply Method                | Manual                                                 |
| VCS Triggers                | Only trigger runs when files in specified paths change |
| Select Syntax               | Prefixes                                               |
| VCS branch                  | build                                                  |

Click on create workspace. Once created, click on New Run and choose run type Plan and apply. This will first plan the deployment and then prompt to apply the changes. Once you have verified the plan, click on on Apply

### 05_k8s-on-prem

In this step, we will

* Create 2 GCE VMs for kubernetes master and worker node
* Configure IP Alias ranges on both nodes for pod IPs

In terraform cloud, create a new Workspace and configure it accordingly

| Key                         | Value                                                  |
|-----------------------------|--------------------------------------------------------|
| Workflow                    | Version Control Workflow                               |
| Version Control Provider    | Github                                                 |
| Repository                  | ``                                                     |
| Workspace Name              | 05_k8s-on-prem                                         |
| Project                     | Default                                                |
| Terraform Working Directory | 05_k8s/on-prem                                         |
| Apply Method                | Manual                                                 |
| VCS Triggers                | Only trigger runs when files in specified paths change |
| Select Syntax               | Prefixes                                               |
| VCS branch                  | build                                                  |

Click on create workspace. Once created, click on New Run and choose run type Plan and apply. This will first plan the deployment and then prompt to apply the changes. Once you have verified the plan, click on on Apply

### Deploy kubernetes on prem

#### Commands to run both in Master and Worker node(s)

In this step, you will login to the master node and all the worker node(s) and run the following commands,

```
mkdir setup
cd setup/
wget https://github.com/containerd/containerd/releases/download/v1.6.8/containerd-1.6.8-linux-amd64.tar.gz
sudo tar Cxzvf /usr/local containerd-1.6.8-linux-amd64.tar.gz
wget https://github.com/opencontainers/runc/releases/download/v1.1.3/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc
wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
sudo mkdir -p /opt/cni/bin
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz
sudo mkdir /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
sudo curl -L https://raw.githubusercontent.com/containerd/containerd/main/containerd.service -o /etc/systemd/system/containerd.service
sudo systemctl daemon-reload
sudo systemctl enable --now containerd
sudo systemctl status containerd
curl -fsSL https://dl.k8s.io/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

cat /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-get install  -y kubelet=1.27.3-00 kubeadm=1.27.3-00 kubectl=1.27.3-00
sudo apt-mark hold kubelet kubeadm kubectl
sudo apt update
sudo apt install -y docker.io
```

#### Commands to run in Master node

In this step, you will login to the master node and run the following commands,

```
# --apiserver-cert-extra-sans is optional, use only if you are exposing the k8s master externally.
# Note down the kubeadm join command from the output. It will be used later.
sudo kubeadm init --pod-network-cidr=192.168.4.0/22 --apiserver-advertise-address=0.0.0.0 --apiserver-cert-extra-sans=<MASTER EXTERNAL IP>

# Create the kubeconfig file to run kubectl commands from master node
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install the k8s network operator
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
curl https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml -O
# Update the pod CIDR
sed -i 's/cidr: .*/cidr: 192.168.4.0\/22/g' custom-resources.yaml
kubectl create -f custom-resources.yaml
```

#### Commands to run in Worker node(s)

In this step, you will login to all the worker node(s) and run the following commands,

```
# Use the kubeadm join command from the output of kubeadm init in master node. A sample kubeadm join look as follows,

sudo kubeadm join 10.128.0.2:6443 --token r2kk47.uq7v6k9ev0h1q8fm         --discovery-token-ca-cert-hash sha256:5a413af08a465acb7e481e130f68ab18d9d25787893daa60825582e5e1a77644
```

#### Verify the k8s installation

Login to the master node and run the following commands to verify if all the worker nodes are registed with master and are in READY state.

```
kubectl get node -o wide
```

#### Registe the on-prem cluster with Anthos

Run the following command to register the on-prem cluster with Anthos fleet

```
gcloud container fleet memberships register on-prem-k8s-cluster        --context=kubernetes-admin@kubernetes   --kubeconfig=~/.kube/config --project=svc-gcp-d349 --enable-workload-identity    --has-private-issuer
```

Go to the Anthos UI, and verify that the on-prem cluster is showing up as part of the fleet.

Setup the connect gateway to login to the registerd on-prem cluster. Add additional users as required.

```
cat << EOF > connect-gateway-rbac.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: gateway-impersonate
rules:
- apiGroups:
  - ""
  resourceNames:
  - lakshmanan@onixnet.us
  - junaid.subhani@onixnet.com
  - alex@cruxocm.ai
  resources:
  - users
  verbs:
  - impersonate
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: gateway-impersonate
roleRef:
  kind: ClusterRole
  name: gateway-impersonate
  apiGroup: rbac.authorization.k8s.io
subjects:
- kind: ServiceAccount
  name: connect-agent-sa
  namespace: gke-connect
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: gateway-cluster-admin
subjects:
- kind: User
  name: lakshmanan@onixnet.us
- kind: User
  name: junaid.subhani@onixnet.com
- kind: User
  name: alex@cruxocm.ai
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io

EOF
```

Apply the rbac to the on-prem cluster

```
kubectl apply -f connect-gateway-rbac.yaml
```

Now from the Anthos UI, you can login to the on-prem cluster with your google credentials.


#### Enable Anthos Features on the on-prem cluster

```
curl https://storage.googleapis.com/csm-artifacts/asm/asmcli_1.18 > asmcli
chmod +x ./asmcli

./asmcli install   --kubeconfig ~/.kube/config   --fleet_id svc-gcp-d349   --output_dir ./output/   --platform multicloud --option attached-cluster --enable_all --ca mesh_ca
```

### 06_anthos-gcp

In this step, we will

* Creates an Anthos fleet
* Adds GKE cluster to the fleet
* Configures Anthos Config Management on GKE cluster

In terraform cloud, create a new Workspace and configure it accordingly

| Key                         | Value                                                  |
|-----------------------------|--------------------------------------------------------|
| Workflow                    | Version Control Workflow                               |
| Version Control Provider    | Github                                                 |
| Repository                  | ``                                                     |
| Workspace Name              | 06_anthos-gcp                                          |
| Project                     | Default                                                |
| Terraform Working Directory | 06_anthos/gcp                                          |
| Apply Method                | Manual                                                 |
| VCS Triggers                | Only trigger runs when files in specified paths change |
| Select Syntax               | Prefixes                                               |
| VCS branch                  | build                                                  |

Click on create workspace. Once created, click on New Run and choose run type Plan and apply. This will first plan the deployment and then prompt to apply the changes. Once you have verified the plan, click on on Apply

### 07_anthos_on-prem

In this step, we will

* Configures Anthos Config Management on on-prem cluster

In terraform cloud, create a new Workspace and configure it accordingly

| Key                         | Value                                                  |
|-----------------------------|--------------------------------------------------------|
| Workflow                    | Version Control Workflow                               |
| Version Control Provider    | Github                                                 |
| Repository                  | ``                                                     |
| Workspace Name              | 06_anthos_on-prem                                      |
| Project                     | Default                                                |
| Terraform Working Directory | 06_anthos/on-prem                                      |
| Apply Method                | Manual                                                 |
| VCS Triggers                | Only trigger runs when files in specified paths change |
| Select Syntax               | Prefixes                                               |
| VCS branch                  | build                                                  |

Click on create workspace. Once created, click on New Run and choose run type Plan and apply. This will first plan the deployment and then prompt to apply the changes. Once you have verified the plan, click on on Apply