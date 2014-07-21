class profile::signalboxes {
  file { '/var/www':
    ensure => 'directory',
    owner  => 'root',
  }

  vcsrepo { '/var/www/signalboxes.net':
    ensure   => 'latest',
    provider => 'git',
    source   => 'https://github.com/joshbeard/signalboxes.net.git',
    group    => 'web',
    require  => File['/var/www'],
  }
}
