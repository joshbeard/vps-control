class profile::awstats {

  $awstats_version     = '7.3'
  $awstats_path        = '/usr/local/awstats'
  $awstats_runinterval = '*/5'
  $logfile             = '/var/log/nginx/signalboxes.net-access.log'
  $sitedomain          = 'signalboxes.net'
  $sitealiases         = [
    'signalboxes.net',
    'www.signalboxes.net',
    '127.0.0.1',
    'localhost',
  ]
  $confdir             = '/etc/awstats'
  $dirdata             = '/var/lib/awstats'
  $wwwdir              = "${awstats_path}/wwwroot"

  File {
    owner => 'root',
    group => 'root',
  }


  file { $confdir:
    ensure => 'directory',
  }

  file { $dirdata:
    ensure => 'directory',
    owner  => 'apache',
    group  => 'apache',
  }

  file { 'awstats_config':
    ensure  => 'file',
    content => template('profile/awstats.conf.erb'),
    path    => "${confdir}/awstats.${sitedomain}.conf",
  }

  staging::deploy { 'awstats-7.3.tar.gz':
    source  => "http://prdownloads.sourceforge.net/awstats/awstats-${awstats_version}.tar.gz",
    target  => '/usr/local',
    creates => "/usr/local/awstats-${awstats_version}",
    user    => 'root',
    group   => 'root',
  }

  file { 'awstats_link':
    ensure  => 'link',
    target  => "/usr/local/awstats-${awstats_version}",
    path    => $awstats_path,
    require => Exec["extract awstats-${awstats_version}.tar.gz"],
  }

  nginx::resource::vhost { 'stats.signalboxes.net':
    www_root    => $wwwdir,
    require     => File[$awstats_path],
  }

  cron { 'awstats_update':
    ensure  => 'present',
    command => "/bin/perl ${awstats_path}/tools/awstats_buildstaticpages.pl -update -config=${sitedomain} -dir=${wwwdir}",
    user    => 'root',
    minute  => $awstats_runinterval,
  }

}
