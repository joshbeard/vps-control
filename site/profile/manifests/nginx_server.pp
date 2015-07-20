## The nginx profile
class profile::nginx_server {
  class { '::nginx':
    server_tokens => 'off',
  }

  if $::osfamily == 'FreeBSD' {
    file { '/etc/newsyslog.conf.d/nginx.conf':
      ensure  => 'file',
      content => '/var/log/nginx/*.log    644     12      *       $M1D0   JGC             /var/run/nginx.pid',
      owner   => 'root',
      group   => 'wheel',
      mode    => '0640',
    }
  }
}
