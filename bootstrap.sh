#!/bin/sh

echo "==> Installing modules from Puppetfile with r10k"
r10k puppetfile install Puppetfile -v

echo "==> Running Puppet apply"
puppet apply manifests/site.pp \
  --modulepath=./modules:./site \
  --hiera_config=hiera.yaml

echo "========================================================================"
echo "#          r10k needs to populate the Puppet environments              #"
echo "========================================================================"
echo
echo "  Do the following:"
echo "    r10k deploy environment -p -v"
echo "    puppet agent -t"
echo
echo "========================================================================"

