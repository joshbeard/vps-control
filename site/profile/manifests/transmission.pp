class profile::transmission {

  class { '::transmission':
    settings => {
      'download-dir'               => '/store/media/Videos/movies',
      'download-queue-size'        => 10,
      'encryption'                 => 2,
      'incomplete-dir'             => '/store/downloads',
      'incomplete-dir-enabled'     => true,
      'prefetch-enabled'           => true,
      'ratio-limit'                => '1',
      'ratio-limit-enabled'        => true,
      'rpc-host-whitelist'         => 'home.jbeard.org,t.jbeard.org',
      'rpc-host-whitelist-enabled' => true,
      'rpc-whitelist-enabled'      => true,
      'speed-limit-up'             => 100,
      'speed-limit-up-enabled'     => true,
    }
  }

}
