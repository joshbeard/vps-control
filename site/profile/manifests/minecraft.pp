class profile::minecraft {

  include mcmyadmin

  mcmyadmin::instance { 'default':
    webserver_port => '8080',
    user           => 'minecraft',
    group          => 'minecraft',
    homedir        => '/home/minecraft',
  }

}
