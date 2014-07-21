class profile::fail2ban {
  class { '::fail2ban':
    jails_config => 'concat',
    ignoreip     => ['127.0.0.1/8', '208.107.129.38/32'],
    mailto       => 'root@localhost',
  }

  ::fail2ban::jail { 'sshd':
    filter  => 'sshd',
    port    => '22431',
    logpath => '/var/log/auth.log',
  }

  ::fail2ban::jail { 'sshd-ddos':
    filter  => 'sshd-ddos',
    port    => '22431',
    logpath => '/var/log/auth.log',
  }

}
