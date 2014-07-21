## The nginx profile
class profile::nginx_server {
  yumrepo { 'nginx':
    ensure   => 'present',
    baseurl  => 'http://nginx.org/packages/centos/$releasever/$basearch/',
    gpgcheck => '0',
  }

  class { '::nginx':
    require => Yumrepo['nginx'],
  }
}
