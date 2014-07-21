##
## Profile for configuring the Puppet agent and master on the vps
##
class profile::puppet {
  include puppet_vim_env

  Ini_setting {
    ensure => 'present',
    path   => "${::settings::confdir}/puppet.conf",
    notify => Service['puppetmaster'],
  }

  host { $::fqdn:
    ensure => 'present',
    ip     => '127.0.0.1',
  }

  file { 'environments':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    path   => "${::settings::confdir}/environments",
  }

  class { 'r10k':
    version       => 'latest',
    sources       => {
      'control'   => {
        'remote'  => '/home/git/repositories/control.git',
        'basedir' => "${::settings::confdir}/environments",
        'prefix'  => false,
      }
    },
    purgedirs         => [ "${::settings::confdir}/environments" ],
    manage_modulepath => false,
    mcollective       => false,
    require           => File['environments'],
    notify => Service['puppetmaster'],
  }

  ini_setting { 'basemodulepath':
    section => 'main',
    setting => 'basemodulepath',
    value   => "${::settings::confdir}/modules",
  }

  ini_setting { 'environmentpath':
    section => 'main',
    setting => 'environmentpath',
    value   => "${::settings::confdir}/environments",
  }

  ini_setting { 'certname':
    section => 'main',
    setting => 'certname',
    value   => "${::fqdn}",
  }

  ini_setting { 'server':
    section => 'main',
    setting => 'server',
    value   => "${::fqdn}",
  }

  class { 'r10k::postrun_command':
    command => 'r10k deploy environment -p',
  }

  class { 'hiera':
    hierarchy => [
      '%{clientcert}',
      '%{environment}',
      'global',
    ],
    datadir      => '/etc/puppet/environments/%{environment}/hieradata',
    backends     => ['yaml'],
    notify => Service['puppetmaster'],
  }

  service { 'puppetmaster':
    ensure => 'running',
    enable => true,
  }

  service { 'puppet':
    ensure => 'running',
    enable => true,
  }

}
