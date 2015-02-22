class profile::zfs {

  zpool { 'store':
    ensure => 'present',
    mirror => [ 'ada1', 'ada2' ],
  }

}
