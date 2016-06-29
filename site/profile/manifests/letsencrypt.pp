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
#   - manage cronjob that'll restart nginx only if a new cert was obtained.
#     the default cronjob restarted nginx even if a new cert was not obtained.
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
    manage_cron          => false,
  }

  letsencrypt::certonly { 'home.jbeard.org':
    domains              => ['home.jbeard.org'],
    plugin               => 'webroot',
    webroot_paths        => ['/var/www/home.jbeard.org'],
    manage_cron          => false,
  }

}
