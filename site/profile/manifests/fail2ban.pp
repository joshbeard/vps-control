class profile::fail2ban {
  include profile::params

  class { '::fail2ban':
    package           => $::profile::params::fail2ban_package,
    config_file       => $::profile::params::fail2ban_config,
    data_dir          => $::profile::params::fail2ban_config_dir,
    config_dir        => $::profile::params::fail2ban_config_dir,
    config_file_group => $::profile::params::fail2ban_group,
    jails_file        => $::profile::params::fail2ban_jails,
    jails_file_group  => $::profile::params::fail2ban_group,
    banaction         => $::profile::params::fail2ban_banaction,
    jails_config      => 'concat',
    ignoreip          => ['127.0.0.1/8', $::ipaddress],
    mailto            => 'root@localhost',
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
