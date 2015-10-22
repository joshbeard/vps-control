class profile::www::home_jbeard {

  file { '/var/www/home.jbeard.org':
    ensure => 'directory',
  }

  openssl::certificate::x509 { 'home.jbeard.org':
    ensure       => 'present',
    country      => 'US',
    organization => 'jbeard.org',
    commonname   => 'home.jbeard.org',
    email        => 'josh@signalboxes.net',
    days         => '3456',
    base_dir     => '/etc/nginx/ssl',
    owner        => 'nginx',
    group        => 'nginx',
    require      => Class['::nginx::package'],
    before       => Nginx::Resource::Vhost['home.jbeard.org'],
  }

}
