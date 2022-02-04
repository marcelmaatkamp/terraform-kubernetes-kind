# terraform: kubernetes wth kind

# pre 

## open files
```
$ sysctl -w fs.file-max=1000000
```

/etc/security/limits.conf 
```
```


## Install docker
{% gist f2ec82d660b96baf1b87eaccfc7d3ff1 %}

# installation
Install dependencies like terraform
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
bin/apply
```

# kubectl
```
$ \
bin/kubectl port-forward -n argocd service/argocd-server --address 0.0.0.0 8080:80
```

![argocd](images/argocd.png)
