class profile::signalboxes {
  file { '/var/www':
    ensure => 'directory',
    owner  => 'root',
  }

  vcsrepo { '/var/www/signalboxes.net':
    ensure   => 'present',
    provider => 'git',
    source   => 'https://github.com/joshbeard/signalboxes.net.git',
    group    => 'web',
    require  => File['/var/www'],
  }

  file { '/var/www/pub.signalboxes.net':
    ensure => 'directory',
    owner  => 'root',
    group  => 'web',
    mode   => '2775',
  }

  vcsrepo { '/var/www/pub.signalboxes.net/fancyindex':
    ensure   => 'present',
    provider => 'git',
    source   => 'https://github.com/joshbeard/Nginx-Fancyindex-Theme.git',
    path     => '/var/www/pub.signalboxes.net/fancyindex',
    group    => 'web',
  }

}
