class profile::params {

  case $::osfamily {
    'FreeBSD': {
      $home_path = '/usr/home'
      $shell     = '/usr/local/bin/zsh'
      $packages = [
        'vim-lite',
      ]
      $fail2ban_package    = 'py27-fail2ban'
      $fail2ban_config     = '/usr/local/etc/fail2ban/fail2ban.local'
      $fail2ban_config_dir = '/usr/local/etc/fail2ban/fail2ban'
      $fail2ban_jails      = '/usr/local/etc/fail2ban/jail.local'
    }
    default: {
      $home_path = '/home'
      $shell     = '/usr/bin/zsh'
      $packages = [
        'vim-minimal',
      ]
      $fail2ban_package    = undef
      $fail2ban_config     = undef
      $fail2ban_config_dir = undef
      $fail2ban_jails      = undef
    }
  }
}
