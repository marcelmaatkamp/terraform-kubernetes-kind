# terraform: kubernetes wth kind

# installation
```
$ \
 sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
 &&\
 curl -fsSL https://apt.releases.hashicorp.com/gpg | \
  sudo apt-key add - &&\
 sudo apt-add-repository \
  "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" &&\
 sudo apt install \
  terraform &&\
 sudo curl -fsSLo \
  /usr/share/keyrings/kubernetes-archive-keyring.gpg \
  https://packages.cloud.google.com/apt/doc/apt-key.gpg &&\
 echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | \
  sudo tee /etc/apt/sources.list.d/kubernetes.list

$ \
 sudo apt install -y \
  terraform \
  kubectl
```

# usage
```
$ \
 terraform init &&\
 terraform plan &&\
 terraform apply -auto-approve

$ \ 
 KUBECTL=.kube/config kubectl get all -A
```
