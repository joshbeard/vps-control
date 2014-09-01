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

  file { $piwik_path:
    ensure => 'directory',
    owner  => 'apache',
    group  => 'apache',
    mode   => '0755',
  }

  staging::deploy { 'piwik.zip':
    source  => 'http://builds.piwik.org/piwik.zip',
    target  => $piwik_path,
    owner   => 'apache',
    group   => 'apache',
    require => File[$piwik_path],
  }

}
