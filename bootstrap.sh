echo "==> Installing r10k"
gem install r10k
cd site
echo "==> Installing modules from Puppetfile with r10k"
r10k puppetfile install Puppetfile -v
cd ..
echo "==> Running Puppet with role::vps"
puppet apply -e 'include role::vps' --modulepath=./modules:./site
