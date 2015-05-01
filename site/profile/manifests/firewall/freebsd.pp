class profile::firewall::freebsd {
  service { 'pf':
    ensure  => 'running',
    enable  => true,
  }

  # The /dev/pf device needs to exist for 'pfctl update' to work. The service
  # provides that.
  class { 'pf':
    template => "${module_name}/pf.erb",
    require  => Service['pf'],
  }

  service { 'pflog':
    ensure  => 'running',
    enable  => true,
    require => Class['pf'],
  }
}
