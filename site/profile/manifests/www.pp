class profile::www (
  Hash $sites = {},
) {
  file { '/var/www':
    ensure => 'directory',
    owner  => 'root',
  }

  create_resources('profile::www::site', $sites)
}
