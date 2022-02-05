#!/bin/bash

# Install Homebrew; @see https://brew.sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install Packer
brew install packer

# Install Terraform
brew install terraform

# Install Git
brew install git

# Install Docker
brew install --cask docker

# Install AWS CLI
brew install awscli

# Install Azure CLI
brew install azure-cli

# Install VSCode
brew install --cask visual-studio-code
