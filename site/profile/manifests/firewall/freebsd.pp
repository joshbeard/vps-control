class profile::firewall::freebsd {

  contain pf

  service { 'pflog':
    ensure  => 'running',
    enable  => true,
    require => Class['pf'],
  }
}
