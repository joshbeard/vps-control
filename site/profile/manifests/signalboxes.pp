class profile::signalboxes {
  file { '/var/www/signalboxes.net':
    ensure => 'directory',
    owner  => 'root',
    group  => 'web',
  }
}
