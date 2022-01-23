# terraform: kubernetes wth kind

# pre 
Must have installed docker, else 
```
$ \
 sudo apt-get remove \
  docker docker-engine docker.io containerd runc &&\
 sudo apt-get update &&\
 sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release &&\
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg &&\
 echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null &&\
 sudo apt update &&\
 sudo apt install -y \
  docker-ce docker-ce-cli containerd.io
```

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
