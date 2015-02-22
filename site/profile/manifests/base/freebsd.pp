class profile::base::freebsd {

  cron { 'freebsd_update':
    ensure  => 'present',
    command => 'freebsd-update cron',
    hour    => '2',
    minute  => '15',
  }

  cron { 'ports_update':
    ensure  => 'present',
    command => 'portsnap cron && portsnap update',
    hour    => '3',
    minute  => '15',
  }

  cron { 'pkg_update':
    ensure  => 'present',
    command => 'pkg update && pkg version -vRL=',
    hour    => '4',
    minute  => '0',
  }

  file { 'dynmotd':
    ensure => 'file',
    path   => '/usr/local/bin/dynmotd.sh',
    mode   => '0755',
    owner  => 'root',
    group  => 0,
    source => 'puppet:///modules/profile/dynmotd.sh',
  }

  cron { 'dynmotd':
    ensure  => 'present',
    command => '/usr/local/bin/dynmotd.sh > /etc/motd',
    minute  => '*/5',
  }

}
