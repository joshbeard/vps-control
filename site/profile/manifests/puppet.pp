class profile::puppet {
  include puppet_vim_env

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
  }

  ini_setting { 'basemodulepath':
    ensure  => 'present',
    path    => "${::settings::confdir}/puppet.conf",
    section => 'main',
    setting => 'basemodulepath',
    value   => "${::settings::confdir}/modules",
  }

  ini_setting { 'environmentpath':
    ensure  => 'present',
    path    => "${::settings::confdir}/puppet.conf",
    section => 'main',
    setting => 'environmentpath',
    value   => "${::settings::confdir}/environments",
  }

  class { 'hiera':
    hierarchy => [
      '%{clientcert}',
      '%{environment}',
      'global',
    ],
    datadir      => '/etc/puppet/environments/%{environment}/hieradata',
    backends     => ['yaml'],
  }

}
