class profile::base {
  File {
    owner  => 'root',
    group  => 0,
    mode   => '0644',
    backup => false,
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
  }

  file { 'motd':
    ensure  => 'file',
    path    => '/etc/motd',
    content => template('profile/motd.erb'),
  }

  package { $packages:
    ensure => 'installed',
  }

  file { '/usr/home/josh':
    ensure => 'directory',
    owner  => 'josh',
    group  => 'josh',
    mode   => '0700',
  }

  file { '/usr/home/josh/.ssh':
    ensure => 'directory',
    owner  => 'josh',
    group  => 'josh',
    mode   => '0700',
  }

  user { 'josh':
    ensure  => 'present',
    comment => 'Josh Beard',
    gid     => 'josh',
    groups  => ['wheel','web'],
    home    => '/usr/home/josh',
    shell   => '/usr/local/bin/zsh',
    uid     => '1000',
    require => Package['zsh'],
  }

  group { 'josh':
    ensure => 'present',
  }

  group { 'web':
    ensure => 'present',
  }

  ssh_authorized_key { 'josh':
    ensure => 'present',
    name   => 'josh',
    user   => 'josh',
    type   => 'ssh-rsa',
    key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDPtIAa54bGh3ZvQkiy4OZ8iuUKJWsvctqc1yF5IlnhhbfzC50Bvl+oMALhH2n03hFmZm2LoRH2qSB1aebeNqL3Resf/9/IihYtFKkrTbaWQH6p2wai+dDj7VBHWhKOJztLZfGlDGogY7rxcFQBJZcdiLQvJPf8YCQReL5UbgJIeS4mV2xQjL6RriVsCKc6eg+PnROQ/rG85GdIhM6fmWrm4+Qu1lhq08i0BWqfLRnv5ZZ3XYsJoiz9QFwcEssbtgvmpAWYmcJorpEdkyQBpXfzGfI5NXaxalJ8An9awZyJzS1ROVeOXeJI6ZcRCgm51BQfzj77QA6Q82SUoCFfho+x',
  }
}
