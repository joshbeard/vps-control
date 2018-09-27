class profile::base::freebsd {

  Cron {
    environment => 'PATH=/bin:/usr/bin:/usr/sbin:/usr/local/bin',
  }

  class { '::pkgng':
    options => [
      'ALIAS              : {',
      '  all-depends: query %dn-%dv,',
      '  annotations: info -A,',
      '  build-depends: info -qd,',
      '  cinfo: info -Cx,',
      '  comment: query -i "%c",',
      '  csearch: search -Cx,',
      '  desc: query -i "%e",',
      '  download: fetch,',
      '  iinfo: info -ix,',
      '  isearch: search -ix,',
      '  prime-list: "query -e \'%a = 0\' \'%n\'",',
      '  leaf: "query -e \'%#r == 0\' \'%n-%v\'",',
      '  list: info -ql,',
      '  noauto = "query -e \'%a == 0\' \'%n-%v\'",',
      '  options: query -i "%n - %Ok: %Ov",',
      '  origin: info -qo,',
      '  outdated: version -vRL=,',
      '  provided-depends: info -qb,',
      '  raw: info -R,',
      '  required-depends: info -qr,',
      '  roptions: rquery -i "%n - %Ok: %Ov",',
      '  shared-depends: info -qB,',
      '  show: info -f -k,',
      '  size: info -sq,',
      '}',
    ],
  }
  pkgng::repo { 'FreeBSD':
    packagehost => 'pkg.freebsd.org',
  }

  cron { 'freebsd_update':
    ensure  => 'present',
    command => 'freebsd-update cron',
    hour    => '2',
    minute  => '15',
  }

  cron { 'ports_update':
    ensure  => 'present',
    command => 'portsnap cron && portsnap update',
    hour    => '3',
    minute  => '15',
  }

  cron { 'pkg_update':
    ensure  => 'present',
    command => 'pkg update && pkg version -vRL=',
    hour    => '4',
    minute  => '0',
  }

  file_line { 'crontab_path':
    ensure => 'present',
    path   => '/etc/crontab',
    line   => 'PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
    match  => '^PATH=',
  }

}
