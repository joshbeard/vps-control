class profile::ssmtp {

  class { '::ssmtp':
    rootEmail  => 'josh@signalboxes.net',
    mailHub    => $::fqdn,
    defaultMta => 'ssmtp',
  }

}
