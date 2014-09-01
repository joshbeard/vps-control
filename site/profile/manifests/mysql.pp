##
## Profile to install the MySQL server
class profile::mysql {

  ## Pull the MySQL root password out of hiera (hiera-eyaml)
  $mysql_root_password = hiera('profile::mysql::root_password')

  class { '::mysql::server':
    root_password => $mysql_root_password,
  }

}
