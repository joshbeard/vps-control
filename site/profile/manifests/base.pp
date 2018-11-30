class profile::base {
  include profile::params
  include ssh

  case $::osfamily {
    'FreeBSD': {
      include profile::base::freebsd
    }
    'RedHat': {
      include profile::base::linux
    }
  }

  class { 'staging':
    path => $::profile::params::staging_path,
  }

  ## Install packages that aren't installed by other modules
  $packages = [
    'irssi',
    'tmux',
    'zsh',
    'lynx',
    'rsync',
    'zip',
  ]

  file { 'issue':
    ensure  => 'file',
    path    => '/etc/issue',
    content => template('profile/issue.erb'),
    owner   => 'root',
    group   => 0,
    mode    => '0644',
    backup  => false,
  }

  package { $packages:
    ensure => 'installed',
  }

  package { $::profile::params::packages:
    ensure => 'installed',
  }

  class { 'ntp': }

  class { 'timezone':
    timezone => 'MST',
  }

  user { 'josh':
    ensure     => 'present',
    comment    => 'Josh Beard',
    gid        => 'josh',
    groups     => ['wheel','web'],
    home       => '/home/josh',
    managehome => true,
    shell      => $::profile::params::shell,
    require    => Package['zsh'],
  }

  group { 'josh':
    ensure => 'present',
  }

  file { '/home/josh/.ssh':
    ensure => 'directory',
    owner  => 'josh',
    group  => 'josh',
    mode   => '0700',
  }

  group { 'web':
    ensure => 'present',
  }

  ssh_authorized_key { 'josh':
    ensure => 'present',
    name   => 'josh',
    user   => 'josh',
    type   => 'ssh-rsa',
    key    => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQC3NO0A5ZE5YAxo16ZuoFjhC2OYzZ6XESGasooMG7GaB6PUjHaG4EWLq5ivDzy8sNO09HbatyzE6Uf0F+xMRa317RjNfWQfVT6SuZNQqVT/Z6Fq3bbQs7uAV7xnEcgtkQtVxQjuN0qwztliELSzF5jdAaXCy0CpoldfiKbgND1rqqUR8sGQN5OVcPkV3/v2klz+D+in4fktjwJhyx4ct1d4K/2DfRISSJUym3Ax8mR5vEfoJuo6OQca0sGiCbyrgn1XGoibW19Y67MeRMcc93y6nKM4N6rzPweWyug/8+X9jFDbnLL/OZfws6XFnhMGro8FuTMFbC6qUQXqPshnJGTeQrZurvTC6Pv/icKkO4wg7J17Ettob3yXpYaqMkTHl3Bfuc16JIUejuaTZpTYZVgPrx5A5Ze+wI3io4neF29S3YpZr4QJEes8ofPxIKYTsywdKfMOVyvlqv1OdAr7ChGhjkzNV8EIETM79EFIzBB3OMELf5fFbaSRJozsWIf63r71hT6QrnTizA1topYGS1l+fBZkvlE+Q9lXn4AvsrSmUYKO+HnbmWdUf/QVmXX9M4YE4FLas4iNJomlZs6P6G0zOKn0EWzjHNJteKdIZOLISg1wBJ6bEP7igX6eIM9hYIKweLWnIm83RZ6Xz0/YKnObyHTOWIImJ4fzD+08o+1AWQ==',
  }

  file { 'dynmotd':
    ensure => 'file',
    path   => '/usr/local/bin/dynmotd.sh',
    mode   => '0755',
    owner  => 'root',
    group  => 0,
    source => 'puppet:///modules/profile/dynmotd.sh',
  }

  cron { 'dynmotd':
    ensure  => 'present',
    command => '/usr/local/bin/dynmotd.sh > /etc/motd',
    minute  => '*/5',
  }

}
