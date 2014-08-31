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


  class { 'php::extension::mcrypt':
    package => 'php-mcrypt',
  }

  class { 'php::extension::gd':
    package => 'php-gd',
  }

  class { 'php::fpm':
    package      => 'php-fpm',
    service_name => 'php-fpm',
  }

  class { '::piwik':
    path => '/var/www/piwik',
    user => 'apache',
  }

}
