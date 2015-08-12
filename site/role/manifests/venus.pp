class role::venus {
  include profile::base
  include profile::zfs
  include profile::ssh
  include profile::sudoers
  include profile::puppet
  include profile::plex
  include profile::minecraft
  include profile::smb
}
