##
## Profile for installing the piwik analytics software
## This requires MySQL and PHP
##
class profile::piwik {
  include ::mysql::bindings::php

  $piwik_mysql_password = hiera('profile::piwik::mysql_password')

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
    'php-gd',
    'php-fpm',
  ]

  package { $php_packages:
    ensure => 'installed',
  }

  service { 'php-fpm':
    ensure  => 'running',
    enable  => true,
    require => Package['php-fpm'],
  }

  class { '::piwik':
    path => '/var/www/piwik',
    user => 'apache',
  }

}
