class profile::signalboxes {
  file { ['/var/www', '/var/www/signalboxes.net']:
    ensure => 'directory',
    owner  => 'root',
    group  => 'web',
    mode   => '0775',
  }
}
