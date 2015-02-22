class profile::plex {
  $base_dir   = '/usr/local/plexdata/Plex Media Server'
  $plugin_dir = '/usr/local/plexdata/Plex Media Server/Plug-ins'

  package { 'plexmediaserver':
    ensure => 'installed',
  }

  file { [ $base_dir, $plugin_dir ]:
    ensure  => 'directory',
    owner   => 'plex',
    group   => 'plex',
    require => Package['plexmediaserver'],
  }

  staging::deploy { 'Plex_Unsupported_App_store.zip':
    source  => 'http://bit.ly/ihqmEu',
    target  => $plugin_dir,
    creates => "${plugin_dir}/UnSupportedAppstore.bundle",
    require => File[$plugin_dir],
    notify  => Service['plexmediaserver'],
  }

  vcsrepo { "${plugin_dir}/LetMeWatchThis.bundle":
    ensure   => 'present',
    provider => 'git',
    source   => 'https://github.com/ReallyFuzzy/LetMeWatchThis.bundle.git',
    require  => File[$plugin_dir],
    notify   => Service['plexmediaserver'],
  }

  service { 'plexmediaserver':
    ensure => 'running',
    enable => true,
  }
}
