# Install Kubernetes (kind) and ArgoCD with Terraform

# Install prerequisites
 * docker
 * terraform 
 * kubectl 
 
## Install docker
Install docker, see 
 - https://gist.github.com/marcelmaatkamp/f2ec82d660b96baf1b87eaccfc7d3ff1

{% gist f2ec82d660b96baf1b87eaccfc7d3ff1 %}

## Install terraform and kind
Install terraform and kubectl, see
 - https://gist.github.com/marcelmaatkamp/48edccf7d631ada926ef81bb883f4b5f

{% gist 48edccf7d631ada926ef81bb883f4b5f %}

# Install kubernetes and argocd
```
$ \
bin/apply
```

# ArgoCD

## Get ArgoCD password
```
$ \
bin/kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
## Connect to ArgoCD
Port forward ArgoCD to http://localhost:8080
```bash
$ \
bin/kubectl port-forward -n argocd service/argocd-server --address 0.0.0.0 8080:80
```
![argocd](images/argocd.png)
![argocd](images/argocd_applications_empty.png)
