Package {
  allow_virtual => true,
}

Vcsrepo {
  provider => 'git',
}

hiera_include('classes')
