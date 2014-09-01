class profile::firewall {

  package { [ 'iptables-utils' ]:
    ensure => 'present',
  }
  ## Include the puppetlabs-firewall class
  class { '::firewall':
    require => [
      Package['iptables-utils'],
    ],
  }

  ## Our pre/post rules
  class { '::profile::firewall::pre': }->
  class { '::profile::firewall::post': }

  ## Now our rules
  firewall { '003 accept ssh':
    proto   => 'tcp',
    action  => 'accept',
    port    => '22431',
    require => Class['::profile::firewall::pre'],
  }

  firewall { '004 accept http':
    proto   => 'tcp',
    action  => 'accept',
    port    => ['80','443'],
    require => Class['::profile::firewall::pre'],
  }

}
