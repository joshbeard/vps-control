class profile::icinga {
  package { 'icinga2':
    ensure => 'installed',
  }
}
