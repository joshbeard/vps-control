# My VPS Puppet Control Repository

## Overview

This is the "control repository" for my personal VPS on DigitalOcean.

I use Puppet Open Source there to manage a single instance.  This should stand
up the system almost completely - minus the variable data that's backed up via
other means.

## Usage

This isn't usable by other people without some modification, obviously.

Once the VPS droplet is created (see my (https://github.com/joshbeard/vps-packer)[Packer template]),
clone this repository to the VPS somewhere (e.g. ~/root/control)

```shell
bash bootstrap
```

This will install r10k, populate a temporary modules directory, and run a
`puppet apply` with the `role::vps` class.

Once that's ran, a Gitolite server will be setup.  The control repo will then
need to be pused to the gitolite server for r10k to use it as a source.

## Disclaimer

This isn't the best example of what code should look like or how to architect
your Puppet modules and environments.
