#!/bin/bash

# Set timezone
TZ=America/Los_Angeles

# Place ourselves in a temporary directory; don't clutter user.home directory w/ downloaded artifacts
cd /tmp

# Set timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Bring OS package management up-to-date
apt update -y

# Install packages from APT
apt install apt-transport-https build-essential curl git software-properties-common sudo tmux unzip wget

# Install Packer
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update -y
sudo apt install terraform packer -y

CROPT=${1:-nerdctl}

case $CROPT in

  docker)
    # Install Docker
    sudo useradd -m docker && echo "docker:docker" | chpasswd
    adduser docker sudo
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
      "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update -y
    sudo apt install docker-ce docker-ce-cli containerd.io -y
    sudo usermod -aG docker $USER
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
    docker run --rm hello-world
    ;;

  nerdtcl)
    curl -LO https://github.com/containerd/nerdctl/releases/download/v0.16.0/nerdctl-full-0.16.0-linux-amd64.tar.gz
    sudo tar Cxzvvf /usr/local nerdctl-full-0.16.0-linux-amd64.tar.gz
    sudo systemctl enable --now containerd
    containerd-rootless-setuptool.sh install
    containerd-rootless-setuptool.sh install-buildkit
    nerdctl container run --rm hello-world
    ;;

esac

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install VSCode
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install code
