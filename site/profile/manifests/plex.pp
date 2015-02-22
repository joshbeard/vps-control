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

  staging::deploy { 'Plex_IceFilms_LetMeWatchThis.zip':
    source  => 'https://forums.plex.tv/index.php?app=core&module=attach&section=attach&attach_id=28513',
    target  => $plugin_dir,
    creates => "${plugin_dir}/LetMeWatchThis.bundle",
  }
}
