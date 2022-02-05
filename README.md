# Bootcamp Automation for Tanzu Application Platform

## Who is this for?

Tanzu Solutions Engineering

### Benefits

* Creates a pattern needed for Solutions Engineers to deliver their own workshops in the field to the community or customers
* Automation could be executed prior to a bootcamp or workshop
* Provision all the underlying cloud infrastructure needed
  * Virtual networks, K8s clusters, container registries, DNS zones, Tools VM per participant
* Allows for a consistent experience for attendees
* Allows trainers to deliver a good experience to all attendees as well as support them throughout


## How to use?

Start by [forking this Github repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo#forking-a-repository).  You're required to [configure your own set of Github secrets](https://github.com/Azure/actions-workflow-samples/blob/master/assets/create-secrets-for-GitHub-workflows.md) that will be leveraged by a collection of [Github Actions](.github/workflows).  Consult the _Configure Github Secrets_ section within each cloud target guide for the secrets to create.  Guides are listed [below](#what-does-it-do).

If you're looking to contribute, clone your fork to your local workstation or laptop, [create a branch](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging) and get to work on that new feature.  This repo is open for [pull requests](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request).


## Prerequisites

* Cloud provider CLIs [aws, az]
* Docker
* Git
* Packer and Terraform

For your convenience a set of scripts exist to install a complement of prerequisite software tools

* [MacOS](scripts/install-prereqs-macos.sh) >= 10.15
* [Ubuntu](scripts/install-prereqs-linux.sh) >= 20.04
* [Windows](scripts/install-prereqs-windows.ps1) >= 10

## What does it do?

It provisions the minimum set of cloud resources needed to begin installing Tanzu Application Platform on

* [Microsoft Azure](AZURE.md)

See [roadmap](ROADMAP.md) for planned capabilities.


## What might you consider after provisioning cloud resources?

* Peruse the public Tanzu Application Platform [installation documentation](https://docs.vmware.com/en/Tanzu-Application-Platform/1.0/tap/GUID-install-intro.html)
* Speed up your installation time by visiting one of these Github repositories
  * Timo Salm's [Unofficial TAP 1.0 Installation Guide](https://github.com/tsalm-pivotal/tap-install)
  * Make Onboarding Suck Less's [TAP 1.0 Evaluation Guides](https://github.com/pacphi/make-onboarding-suck-less/tree/main/scripts/tanzu/application-platform)
* Consider using Visual Studio Code as your IDE
  * Add [recommended extensions](https://code.visualstudio.com/docs/editor/extension-marketplace#_workspace-recommended-extensions) to your workspace
  * Setup [Remote development over SSH](https://code.visualstudio.com/docs/remote/ssh-tutorial)