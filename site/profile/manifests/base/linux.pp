class profile::base::linux {
  include ::epel
  include ::packagecloud
  include ::selinux

  Package <<| provider == 'yum' |>>{
    require => Class['::epel'],
  }

  selinux::port { 'ssh_port':
    ensure   => 'present',
    seltype  => 'ssh_port_t',
    protocol => 'tcp',
    port     => 22431,
  }

  packagecloud::repo { 'github/git-lfs':
   type => 'rpm',
  }

  package { 'git-lfs':
    ensure  => 'latest',
    require => Packagecloud::Repo['github/git-lfs'],
  }
}
