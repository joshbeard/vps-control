class profile::www::home_jbeard {

  file { '/var/www/home.jbeard.org':
    ensure => 'directory',
    notify => Class['::nginx'],
  }

}
