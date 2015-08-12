class profile::firewall {
  if $::osfamily == 'FreeBSD' {
    include profile::firewall::freebsd
  }
  else {
    include profile::firewall::linux
  }
}
