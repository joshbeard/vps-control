#
# Very preliminary letsencrypt management
#
# TODO:
#   - manage installation and use certbot
#     - track upstream progress: https://github.com/danzilio/puppet-letsencrypt
#   - work out ordering: using webroot for authenticating means we can't start
#     nginx until we have the cert.  but we need nginx running (80) to get the
#     cert. standalone might be the way to go.  is this working on freebsd?
#   - move the certonly stuff to vhost-specific profiles
#
class profile::letsencrypt {
  class { '::letsencrypt':
    configure_epel  => false,
    manage_install  => false,
    manage_config   => false,
    email           => 'josh@signalboxes.net',
    package_command => '/usr/local/bin/letsencrypt',
    install_method  => 'package',
  }

  letsencrypt::certonly { 'plex.jbeard.org':
    domains              => ['plex.jbeard.org'],
    plugin               => 'webroot',
    webroot_paths        => ['/var/www/plex.jbeard.org'],
    manage_cron          => true,
    cron_success_command => '/usr/sbin/service nginx restart',
  }

  letsencrypt::certonly { 'home.jbeard.org':
    domains              => ['home.jbeard.org'],
    plugin               => 'webroot',
    webroot_paths        => ['/var/www/home.jbeard.org'],
    manage_cron          => true,
    cron_success_command => '/usr/sbin/service nginx restart',
  }
}
