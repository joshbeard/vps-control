class profile::awstats {

  $awstats_path        = '/usr/local/awstats'
  $awstats_runinterval = '*/5'
  $logfile             = '/var/log/nginx/signalboxes.access.log'
  $sitedomain          = 'signalboxes.net'
  $sitealiases         = [
    'signalboxes.net',
    'www.signalboxes.net',
    '127.0.0.1',
    'localhost',
  ]
  $dirdata             = '/var/lib/awstats'

  File {
    owner => 'root',
    group => 'root',
  }

  file { $awstats_path:
    ensure => 'directory',
  }

  file { '/etc/awstats':
    ensure => 'directory',
  }

  file { 'awstats_config':
    ensure  => 'file',
    content => template('profile/awstats.conf.erb'),
    path    => '/etc/awstats/awstats.signalboxes.net.conf',
  }

  staging::deploy { 'awstats-7.3.tar.gz':
    source  => 'http://prdownloads.sourceforge.net/awstats/awstats-7.3.tar.gz'
    target  => $awstats_path,
    user    => 'root',
    group   => 'root',
    require => File[$awstats_path],
  }

  nginx::resource::vhost { 'stats.signalboxes.net':
    www_root    => $awstats_path,
    require     => File[$awstats_path],
  }

  cron { 'awstats_update':
    ensure  => 'present',
    command => '/usr/local/awstats/tools/awstats_updateall.pl now',
    user    => 'root',
    minute  => $awstats_runinterval,
  }

}
