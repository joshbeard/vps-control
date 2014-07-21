class role::vps {
  include profile::base
  include profile::nginx_server
  include profile::ssh
  include profile::sudoers
  include profile::puppet
  include profile::gitolite
}
