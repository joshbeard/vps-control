class role::vps {
  include profile::base
  include profile::fail2ban
  include profile::firewall
  include profile::signalboxes
  include profile::nginx_server
  include profile::ssh
  include profile::sudoers
  include profile::puppet
  #include profile::awstats
}
