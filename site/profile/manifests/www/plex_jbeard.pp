class profile::www::plex_jbeard {

  file { '/var/www/plex.jbeard.org':
    ensure => 'directory',
  }

}
