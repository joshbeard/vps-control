class profile::zfs {

  zpool { 'store':
    ensure => 'present',
    mirror => 'ada1 ada2',
  }

  file { '/store/media':
    ensure  => 'directory',
    require => Zpool['store'],
  }

  service { 'zfs':
    enable => true,
  }

}
