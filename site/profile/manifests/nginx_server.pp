## The nginx profile
class profile::nginx_server {
  include ::nginx

  file { 'nginx_ssl':
    ensure => 'directory',
    owner  => $::nginx::params::daemon_user,
    group  => '0',
    mode   => '0700',
    path   => "${::nginx::params::conf_dir}/ssl",
    before => Service['nginx'],
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
