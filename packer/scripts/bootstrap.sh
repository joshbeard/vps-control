#!/bin/bash
set +xe

PATH="/usr/bin:/usr/local/bin:/bin:/sbin:/usr/sbin:/usr/local/sbin:/opt/puppetlabs/bin"

yum update -y

echo "==> Adding Puppet Labs YUM Repo"
rpm -Uvh https://yum.puppet.com/puppet6/puppet6-release-el-7.noarch.rpm
yum makecache

echo "==> Installing puppet and git"
yum install -y puppet-agent git

echo "==> Cleaning yum"
yum clean all
rm -rf /var/cache/yum

echo $(date) > /etc/image_birthdate

echo "==> Installing r10k"
/opt/puppetlabs/puppet/bin/gem install r10k --no-ri --no-rdoc

echo "==> Creating Puppet symlinks"
ln -s /opt/puppetlabs/bin/puppet /usr/local/bin/puppet
ln -s /opt/puppetlabs/bin/facter /usr/local/bin/facter
ln -s /opt/puppetlabs/bin/hiera /usr/local/bin/hiera
ln -s /opt/puppetlabs/puppet/bin/r10k /usr/local/bin/r10k

echo "==> Creating local user"
puppet resource group josh ensure=present
puppet resource user josh ensure=present home=/home/josh managehome=true gid=josh groups=wheel
puppet resource ssh_authorized_key josh ensure=present user=josh type=ssh-rsa key="AAAAB3NzaC1yc2EAAAADAQABAAACAQC3NO0A5ZE5YAxo16ZuoFjhC2OYzZ6XESGasooMG7GaB6PUjHaG4EWLq5ivDzy8sNO09HbatyzE6Uf0F+xMRa317RjNfWQfVT6SuZNQqVT/Z6Fq3bbQs7uAV7xnEcgtkQtVxQjuN0qwztliELSzF5jdAaXCy0CpoldfiKbgND1rqqUR8sGQN5OVcPkV3/v2klz+D+in4fktjwJhyx4ct1d4K/2DfRISSJUym3Ax8mR5vEfoJuo6OQca0sGiCbyrgn1XGoibW19Y67MeRMcc93y6nKM4N6rzPweWyug/8+X9jFDbnLL/OZfws6XFnhMGro8FuTMFbC6qUQXqPshnJGTeQrZurvTC6Pv/icKkO4wg7J17Ettob3yXpYaqMkTHl3Bfuc16JIUejuaTZpTYZVgPrx5A5Ze+wI3io4neF29S3YpZr4QJEes8ofPxIKYTsywdKfMOVyvlqv1OdAr7ChGhjkzNV8EIETM79EFIzBB3OMELf5fFbaSRJozsWIf63r71hT6QrnTizA1topYGS1l+fBZkvlE+Q9lXn4AvsrSmUYKO+HnbmWdUf/QVmXX9M4YE4FLas4iNJomlZs6P6G0zOKn0EWzjHNJteKdIZOLISg1wBJ6bEP7igX6eIM9hYIKweLWnIm83RZ6Xz0/YKnObyHTOWIImJ4fzD+08o+1AWQ=="
puppet resource user root password="*"

echo "==> Adding sudoers rule to /etc/sudoers.d/10_josh"
echo "josh ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/10_josh
