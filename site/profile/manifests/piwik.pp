##
## Profile for installing the piwik analytics software
## This requires MySQL and PHP
##
class profile::piwik {
  include ::mysql::bindings::php

  $piwik_mysql_password = hiera('profile::piwik::mysql_password')
  $piwik_path           = '/var/www/piwik'

  mysql::db { 'piwik':
    ensure   => 'present',
    user     => 'piwik',
    password => $piwik_mysql_password,
    host     => 'localhost',
    dbname   => 'piwik',
    grant    => ['ALL'],
  }

  $php_packages = [
    'php-mcrypt',
    'php-mbstring',
    'php-gd',
    'php-xml',
  ]

  package { 'php-fpm':
    ensure => 'installed',
  }

  package { $php_packages:
    ensure => 'installed',
    notify => Service['php-fpm'],
  }

  service { 'php-fpm':
    ensure  => 'running',
    enable  => true,
    require => Package['php-fpm'],
  }

  file { $piwik_path:
    ensure => 'directory',
    owner  => 'apache',
    group  => 'apache',
    mode   => '0755',
  }

  staging::deploy { 'piwik.zip':
    source  => 'http://builds.piwik.org/piwik.zip',
    target  => '/var/www',
    user    => 'apache',
    group   => 'apache',
    creates => "${piwik_path}/index.php",
    require => File[$piwik_path],
  }

  nginx::resource::vhost { 'piwik.signalboxes.net':
    www_root    => $piwik_path,
    index_files => [ 'index.php' ],
    require     => File[$piwik_path],
  }

  nginx::resource::location { 'piwik_root':
    ensure         => 'present',
    vhost          => 'piwik.signalboxes.net',
    www_root       => $piwik_path,
    location       => '~ \.php$',
    proxy          => undef,
    fastcgi        => '127.0.0.1:9000',
    fastcgi_script => undef,
  }

}
