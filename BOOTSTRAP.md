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

// TODO
// Add commands to install k8s

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