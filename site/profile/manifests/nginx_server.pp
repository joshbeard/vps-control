## The nginx profile
class profile::nginx_server {
  class { '::nginx':
    server_tokens => 'off',
  }

  file { '/var/log/nginx':
    ensure => 'directory',
  }
}
