# Introduction
Following project deploys EKS cluster together with Karpenter.

Solution based on: https://aws-ia.github.io/terraform-aws-eks-blueprints/patterns/karpenter-mng/

# Deployment
## Prerequisites
1. Create S3 Bucket and provide it's name and region in the `terraform.tf` file.
2. You alerady have VPC with public and private subnets.
3. For subnets you want to use for cluster nodes add tag `karpenter.sh/discovery=YOUR_CLUSTER_NAME`.

## Deployment
1. from `k8s-with-karpenter` directory run `terraform init`
2. Run `terraform apply -target="module.eks"`. Follow the prompt. This will create eks.
3. Run `terraform output` to see command, to connect to your cluster, ex. `aws eks update-kubeconfig --name YOUR_CLUSTER_NAME`
4. Run `terraform apply`. Follow the prompt. This will create Karpenter resources, without it's configuration.
5. Adjust configuration of karpenter at `nodepool.yaml` - provide cluster name in relevant places.
6. Run `kubectl apply -f .\nodepool.yaml` to deploy karpenter's configuration.

By now it should work, you can check it by creating some large deployment (few pods with high requested resources, like 1-2 cpu).

You can also check for the karpenter logs by typing `kubectl get pods -n karpenter` and by providing karpenter's POD_ID to `kubectl logs POD_ID -n karpenter` command.

# Access cluster control plane
## Prerequisites
Have locally installed:
1. kubectl
2. aws cli

## Setup
Update kubeconfig locally with:
`aws eks update-kubeconfig --name YOUR_CLUSTER_NAME --region eu-west-1`

# Troubleshooting
1. If scaling doesn't work, then run `kubectl logs deployment/karpenter -n karpenter | grep ServiceLinkedRoleCreationNotPermitted`. If it has any output, run `aws iam create-service-linked-role --aws-service-name spot.amazonaws.com` (as per oficial Karpenter [documentation](https://karpenter.sh/docs/troubleshooting/#missing-service-linked-role))