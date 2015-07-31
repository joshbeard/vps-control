class profile::firewall::freebsd {

  class { 'pf':
    template => "${module_name}/pf.erb",
  }

  service { 'pflog':
    ensure  => 'running',
    enable  => true,
    require => Class['pf'],
  }
}
