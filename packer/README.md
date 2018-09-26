# My VPS Packer

## Overview

This Packer template creates a DigitalOcean image for my personal VPS.

## Usage

This isn't usable by other people without some modifications, of course.

First, an API token needs to be created in DigialOcean that can be used here.

An API token needs to be provided.

```shell
DIGITALOCEAN_API_TOKEN="<the token>" packer build vps.json
```

Once the image is built, login to DigitalOcean and create a new droplet that
uses the image that this creates.
