## Roadmap

Once all individual Terraform modules have been implemented targeting Azure:

### MVP-1

* ~~Configure an action to invoke the aggregate N times to create new and/or teardown existing aggregates~~
* [x] Document how to fork and re-use this repository
* [x] Create a Github Action that chains calls to individual Github Actions capable of delivering a "one-click" deployment (for each cloud provider)
  * [x] and support "one-click" tear-down
* [x] Vend credentials to cluster and container registry in a secure manner to bastion

### MVP-2

* Rinse and repeat implementation patterns targeting other cloud providers
  * [ ] AWS
  * [ ] Google

### MVP-3

* [ ] Create aggregate "all-in-one" Terraform module that is capable of building modules together (for each cloud provider)
* [ ] Implement a Github Action that triggers an automated TAP install workflow