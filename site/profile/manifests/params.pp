class profile::params {

  case $::osfamily {
    'FreeBSD': {
      $home_path = '/usr/home'
      $shell     = '/usr/local/bin/zsh'
      $packages = [
        'vim-lite',
      ]
    }
    default: {
      $home_path = '/home'
      $shell     = '/usr/bin/zsh'
      $packages = [
        'vim-minimal',
      ]
    }
  }
}
