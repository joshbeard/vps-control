class profile::www::home_jbeard {

  file { '/var/www/home.jbeard.org':
    ensure => 'directory',
    notify => Class['::nginx'],
  }

  openssl::certificate::x509 { 'home.jbeard.org':
    ensure       => 'present',
    country      => 'US',
    organization => 'jbeard.org',
    commonname   => 'home.jbeard.org',
    email        => 'josh@signalboxes.net',
    days         => '3456',
    base_dir     => "${::nginx::params::conf_dir}/ssl",
    owner        => $::nginx::params::daemon_user,
    group        => $::nginx::params::root_group,
    require      => Class['::nginx::package'],
    before       => Nginx::Resource::Server['home.jbeard.org'],
  }

}
