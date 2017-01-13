case $::osfamily {
  'FreeBSD': {
    $pkg_provider = 'pkgng'
  }
  default: {
    $pkg_provider = undef
  }
}

Package {
  allow_virtual => true,
  provider      => $pkg_provider,
}

Vcsrepo {
  provider => 'git',
}

hiera_include('classes')
