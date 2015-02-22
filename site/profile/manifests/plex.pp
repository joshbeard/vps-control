class profile::plex {
  $plugin_dir = "/usr/local/share/plexmediaserver/Resources/Plug-ins"

  package { 'plexmediaserver':
    ensure => 'installed',
  }

  service { 'plexmediaserver':
    ensure => 'running',
    enable => true,
  }

  file { 'Plex_Plugin_dir':
    ensure  => 'directory',
    path    => "/usr/local/share/plexmediaserver/Resources/Plug-ins",
  }

  staging::deploy { 'Plex_Unsupported_App_store',
    source  => 'http://bit.ly/ihqmEu',
    target  => $plugin_dir,
    creates => "${plugin_dir}/UnSupportedAppstore.bundle",
  }

  vcsrepo { "${plugin_dir}/LetMeWatchThis.bundle":
    ensure   => 'present',
    provider => 'git',
    source   => 'https://github.com/ReallyFuzzy/LetMeWatchThis.bundle.git',
  }
}
