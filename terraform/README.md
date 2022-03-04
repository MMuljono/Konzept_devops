## Prerequisites
  - Git clone kubespray to this folder [Github_URL](https://github.com/kubernetes-sigs/kubespray)
  - create SSH Key pair for connecting to EC2
    > mkdir -p ./.ssh \
      ssh-keygen -t rsa -b 4096 -C "operator" -N "" -f ./.ssh/operator \
      chmod 600 ./.ssh/operator*
  
## Disclaimer 
  - This provisioning of Terraform and Kubespray is modified version from [tutorial-10](https://github.com/lucendio/lecture-devops-code/tree/master/tutorials/10_provision-kubernetes)


Once Terraform and Kubespray are done provisioning the kubernetes cluster, run these two commands to access the kubernetes cluster.
  > export KUBECONFIG=$(pwd)/admin.conf \
  > export KUBE_API_HOST=$(jq -r '.all.hosts.instance1.ansible_host' ./inventory/hosts.yaml) yq --in-place -y --yaml-output \
    ".clusters[0].cluster.server = \"https://${KUBE_API_HOST}:6443\"" \
    ./admin.conf


Next step is to set up the DNS targets group in AWS and copy the address to Cloudflare (or any other providers)
