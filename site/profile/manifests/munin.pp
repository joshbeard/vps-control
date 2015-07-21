class profile::munin {

  include ::munin::master

  munin::master::node_definition { 'signalboxes.net':
    address => '127.0.0.1',
    config  => [
      'use_node_name yes',
    ],
  }

}
