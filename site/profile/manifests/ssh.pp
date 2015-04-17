class profile::ssh {
  class { '::ssh':
    server_options      => {
      'PermitRootLogin' => 'no',
      'Port'            => [22431],
      'PrintMotd'       => 'yes',
    }
  }
}
