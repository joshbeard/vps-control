class profile::transmission {

  file { '/var/www/t.jbeard.org':
    ensure => 'directory',
  }

  class { '::transmission':
    settings => {
      'download-dir'           => '/store/media/Videos/movies',
      'download-queue-size'    => 10,
      'encryption'             => 2,
      'incomplete-dir'         => '/store/downloads',
      'incomplete-dir-enabled' => true,
      'ratio-limit'            => 0,
      'ratio-limit-enabled'    => true,
      'rpc-whitelist-enabled'  => false,
      'speed-limit-up'         => 0,
      'speed-limit-up-enabled' => true,
    }
  }

}
