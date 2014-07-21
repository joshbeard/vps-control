class profile::firewall {
  ## Make sure pre and post happens in the right order
  Firewall {
    before  => Class['profile::firewall::post'],
    require => Class['profile::firewall::pre'],
  }

  ## Include the puppetlabs-firewall class
  class { '::firewall': }

  ## Our pre/post rules
  class { '::profile::firewall::pre': }
  class { '::profile::firewall::post': }

  ## Now our rules
  firewall { '003 accept ssh':
    proto  => 'tcp',
    action => 'accept',
    port   => '22431',
  }

  firewall { '004 accept http':
    proto  => 'tcp',
    action => 'accept',
    port   => ['80','443'],
  }

  firewall { '005 accept irssi proxy':
    proto  => 'tcp',
    action => 'accept',
    port   => ['2777', '2778'],
  }

  firewall { '006 accept mcmyadmin':
    proto  => 'tcp',
    action => 'accept',
    port   => '8090',
  }

  firewall { '007 accept minecraft':
    proto  => 'tcp',
    action => 'accept',
    port   => '25565',
  }
}
