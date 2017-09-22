# My VPS Puppet Control Repository

## Overview

This is the "control repository" for my personal VPS on DigitalOcean.

I use Puppet Open Source there to manage a single instance.  This should stand
up the system almost completely - minus the variable data that's backed up via
other means.

## Usage

This isn't usable by other people without some modification, obviously.

1. Ensure git is installed
2. Ensure Puppet is installed
3. Clone this repository to the node
4. Change into the cloned directory, and run the `bootstrap.sh` script.

For example:

```shell
cd
git clone https://github.com/joshbeard/vps-control.git control
cd control
./bootstrap.sh
```

This will install r10k, populate a temporary modules directory, and run a
`puppet apply` on `manifests/site.pp`.

Once that's ran, r10k will need to be ran to populate the Puppet environments:
`r10k deploy environment -pv`

## Disclaimer

This isn't the best example of what code should look like or how to architect
your Puppet modules and environments.
