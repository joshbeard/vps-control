class profile::minecraft (
  Hash[Hash] $servers = {},
) {
  # Set the dynmap webserver port
  $servers.each |$server, $params| {
    file_line { "${server} dynmap port":
      ensure => 'present',
      path   => "${::minecraft::install_base}/${server}/plugins/dynmap/configuration.txt",
      line   => "webserver-port: ${params['dynmap_port']}",
      match  => '/^webserver-port: \d+$',
    }
  }
}
