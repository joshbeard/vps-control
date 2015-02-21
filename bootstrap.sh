#!/bin/bash

if [ $os == 'FreeBSD' ]; then
  /usr/sbin/pkg update
  /usr/sbin/pkg -y install puppet
fi

MYSELF=$(facter ipaddress)

echo "==> Installing r10k"
gem install r10k

echo "==> Installing modules from Puppetfile with r10k"
r10k puppetfile install Puppetfile -v

echo "==> Running Puppet with role::vps"
puppet apply -e 'include role::vps' --modulepath=./modules:./site


echo "========================================================================"
echo "#          r10k needs to populate the Puppet environments              #"
echo "========================================================================"
echo
echo "  Do the following:"
echo "    r10k deploy environment -p -v"
echo "    puppet agent -t"
echo
echo "========================================================================"

