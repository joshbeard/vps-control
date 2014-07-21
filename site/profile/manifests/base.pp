class profile::base {
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    backup => false,
  }

  include epel

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

  ## Install packages that aren't installed by other modules
  $packages = [
    'irssi',
    'tmux',
    'zsh',
    'lynx',
    'rsync',
    'zip',
  ]

  package { $packages:
    ensure => 'installed',
  }

  user { 'josh':
    ensure  => 'present',
    comment => 'Josh Beard',
    gid     => '1000',
    groups  => ['wheel'],
    home    => '/home/josh',
    shell   => '/usr/bin/zsh',
    uid     => '1000',
    require => Package['zsh'],
  }

  group { 'web':
    ensure => 'present',
  }

  ssh_authorized_key { 'josh':
    ensure => 'present',
    name   => 'josh',
    user   => 'josh',
    key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDPtIAa54bGh3ZvQkiy4OZ8iuUKJWsvctqc1yF5IlnhhbfzC50Bvl+oMALhH2n03hFmZm2LoRH2qSB1aebeNqL3Resf/9/IihYtFKkrTbaWQH6p2wai+dDj7VBHWhKOJztLZfGlDGogY7rxcFQBJZcdiLQvJPf8YCQReL5UbgJIeS4mV2xQjL6RriVsCKc6eg+PnROQ/rG85GdIhM6fmWrm4+Qu1lhq08i0BWqfLRnv5ZZ3XYsJoiz9QFwcEssbtgvmpAWYmcJorpEdkyQBpXfzGfI5NXaxalJ8An9awZyJzS1ROVeOXeJI6ZcRCgm51BQfzj77QA6Q82SUoCFfho+x',
  }
}
