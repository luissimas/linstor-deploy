# Linstor deploy

A collection of Ansible playbooks and Terraform resources to quickly deploy a functional Linstor cluster on top of an existing Incus deployment.

## Getting started

Create the VMs using Terraform:

```shell
cd terraform/
terraform init
terraform apply
```

Run the Ansible playbook to deploy Linstor:

```shell
cd ../ansible
cp hosts.yaml.example hosts.yaml
ansible-playbook deploy.yaml
```

Check the deployment:

```shell
linstor node list
```
