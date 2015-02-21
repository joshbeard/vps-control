class profile::base::freebsd {

  cron { 'freebsd_update':
    ensure  => 'present',
    command => 'freebsd-update cron',
    hour    => '2',
  }

  cron { 'ports_update':
    ensure  => 'present',
    command => 'portsnap cron && portsnap update',
    hour    => '3',
  }

  cron { 'pkg_update':
    ensure  => 'present',
    command => 'pkg update && pkg version -vRL=',
    hour    => '4',
  }

}
