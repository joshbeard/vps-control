class profile::sudoers {
  include sudo

  sudo::conf { 'josh':
    ensure  => 'present',
    content => 'josh ALL=(ALL) NOPASSWD: ALL',
  }
}
