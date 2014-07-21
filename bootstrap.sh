echo "==> Installing r10k"
gem install r10k

echo "==> Installing modules from Puppetfile with r10k"
r10k puppetfile install Puppetfile -v

echo "==> Running Puppet with role::vps"
puppet apply -e 'include role::vps' --modulepath=./modules:./site


echo "========================================================================"
echo "#             The control repository needs to be pushed                #"
echo "========================================================================"
echo " On your local machine:"
echo "    git clone git@${MYSELF}:gitolite-admin.git"
echo "      - Add the control repo to gitolite-admin/conf/gitolite.conf"
echo "      - Commit and push gitolite-admin"
echo
echo "    Push the control repository to:"
echo "      git@${MYSELF}:control.git"
echo
echo " After it's pushed, do:"
echo "    r10k deploy environment -p -v"
echo "    puppet agent -t"
echo
echo "========================================================================"

