class profile::sensu {

  $sensu_subscribers = [ 'base', downcase($::operatingsystem) ]

  $rabbitmq_host     = 'localhost'
  $rabbitmq_vhost    = 'sensu'
  $rabbitmq_password = 'rabbitmq'
  $api_user          = 'localhost'
  $api_password      = 'sensu'

  package { 'erlang':
    ensure => 'installed',
  }

  class { 'rabbitmq':
    require => Package['erlang'],
  }

  rabbitmq_vhost { $rabbitmq_vhost: }

  rabbitmq_user { 'sensu':
    password => $rabbitmq_password,
  }

  rabbitmq_user_permissions { "sensu@${rabbitmq_vhost}":
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  }

  class { 'redis::install': }
  redis::server { 'localhost_sensu': }

  class { '::sensu':
    server            => true,
    purge_config      => true,
    manage_services   => true,
    manage_user       => true,
    rabbitmq_vhost    => $rabbitmq_vhost,
    rabbitmq_password => $rabbitmq_password,
    rabbitmq_host     => 'localhost',
    subscriptions     => $sensu_subscribers,
    api               => true,
    api_user          => $api_user,
    api_password      => $api_password,
    use_embedded_ruby => true,
  }

  ## Uchiwa is the open source dashboard for Sensu.
  ## This module is provided by Yelp
  class { '::uchiwa':
    install_repo        => false,
    host                => '127.0.0.1',
    port                => '3000',
    sensu_api_endpoints => [
      {
        name     => 'sensu',
        host     => '127.0.0.1',
        ssl      => false,
        insecure => false,
        port     => '4567',
        user     => $api_user,
        pass     => $api_password,
        path     => '',
        timeout  => 5,
      },
    ],
  }

  sensu::handler { 'mail':
    command => 'mail -s "sensu alert" josh@signalboxes.net',
  }

}
