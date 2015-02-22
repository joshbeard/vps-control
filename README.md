# My VPS Puppet Control Repository

## Overview

This is the "control repository" for my personal VPS on DigitalOcean and some
home servers.

This should stand up the system almost completely - minus the variable data
that's backed up via other means.

Currently supports CentOS and FreeBSD 10.

## Usage

This isn't usable by other people without some modification, obviously.

Once the VPS droplet is created (see my [https://github.com/joshbeard/vps-packer](Packer template)),
clone this repository to the VPS somewhere and run the `bootstrap` script.

For example:

```shell
cd
git clone https://github.com/joshbeard/vps-control.git control.git
cd control
bash bootstrap.sh
```

This will install r10k, populate a temporary modules directory, and run a
`puppet apply` with the `role::vps` class.

Once that's ran, r10k will need to be ran to populate the Puppet environments:
`r10k deploy environment -pv`

## Disclaimer

This isn't the best example of what code should look like or how to architect
your Puppet modules and environments.
