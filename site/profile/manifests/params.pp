class profile::params {
  $home_path = '/home'

  case $::osfamily {
    'FreeBSD': {
      $shell     = '/usr/local/bin/zsh'
      $packages = [
        'vim-lite',
      ]
      $fail2ban_package    = 'py27-fail2ban'
      $fail2ban_config     = '/usr/local/etc/fail2ban/fail2ban.local'
      $fail2ban_config_dir = '/usr/local/etc/fail2ban/fail2ban'
      $fail2ban_jails      = '/usr/local/etc/fail2ban/jail.local'
      $fail2ban_group      = 0
      $fail2ban_banaction  = 'pf'

      $puppet_path         = '/usr/local/bin/puppet'
      $r10k_path           = '/usr/local/bin/r10k'
      $staging_path        = '/usr/local/staging'
      $hiera_yaml          = '/usr/local/etc/puppet/hiera.yaml'
      $r10k_config_file    = '/etc/puppetlabs/r10k/r10k.yaml'
    }
    default: {
      $shell     = '/bin/zsh'
      $packages = [
        'vim-enhanced',
      ]
      $fail2ban_package    = undef
      $fail2ban_config     = undef
      $fail2ban_config_dir = undef
      $fail2ban_jails      = undef
      $fail2ban_group      = undef
      $fail2ban_banaction  = undef

      $puppet_path         = '/usr/local/bin/puppet'
      $r10k_path           = '/usr/local/bin/r10k'
      $staging_path        = '/opt/staging'
      $hiera_yaml          = undef
      $r10k_config_file    = undef
    }
  }
}
