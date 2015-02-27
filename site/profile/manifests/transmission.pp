class profile::transmission {
  $packages = [
    'transmission-daemon',
    'transmission-cli',
  ]

  package { $packages:
    ensure => 'installed',
  }
}
