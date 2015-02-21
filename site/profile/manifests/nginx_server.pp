## The nginx profile
class profile::nginx_server {
  class { '::nginx': }

  file { '/var/log/nginx':
    ensure => 'directory',
  }
}
