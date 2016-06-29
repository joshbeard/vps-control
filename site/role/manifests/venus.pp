class role::venus {
  include profile::base
  include profile::zfs
  include profile::ssh
  include profile::sudoers
  include profile::puppet
  include profile::plex
  include profile::minecraft
  include profile::smb
  include profile::nginx_server
  include profile::www::home_jbeard
  include profile::www::plex_jbeard
  include profile::transmission
  include profile::letsencrypt
}
