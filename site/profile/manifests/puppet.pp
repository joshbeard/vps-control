##
## Profile for configuring the Puppet agent and master on the vps
##
class profile::puppet {
  include puppet_vim_env

  Ini_setting {
    ensure  => 'present',
    path    => "${::settings::confdir}/puppet.conf",
    section => 'main',
    notify  => Service['puppetmaster'],
  }

  ## For hiera-eyaml
  $hiera_eyaml_config = [
    ':eyaml:',
    "  :datadir: ${::settings::confdir}/environments/%{environment}/hieradata",
    "  :pkcs7_private_key: ${::settings::confdir}/keys/private_key.pkcs7.pem",
    "  :pkcs7_public_key: ${::settings::confdir}/keys/public_key.pkcs7.pem",
    '  :extension: "yaml"',
  ]

  ## Static entry in /etc/hosts
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

  ## Configure r10k
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
    notify            => Service['puppetmaster'],
  }

  ## Various settings for the Puppet master
  ini_setting { 'basemodulepath':
    setting => 'basemodulepath',
    value   => "${::settings::confdir}/modules",
  }

  ini_setting { 'environmentpath':
    setting => 'environmentpath',
    value   => "${::settings::confdir}/environments",
  }

  ini_setting { 'certname':
    setting => 'certname',
    value   => $::fqdn,
  }

  ini_setting { 'server':
    setting => 'server',
    value   => $::fqdn,
  }

  ## Manage hiera-eyaml's key directory
  file { 'eyaml_keys':
    ensure => 'directory',
    path   => "${::settings::confdir}/keys",
    owner  => 'puppet',
    group  => 'puppet',
    mode   => '0600',
  }

  ## Install hiera-eyaml via Rubygems
  package { 'hiera-eyaml':
    ensure   => 'installed',
    provider => 'gem',
  }

  ## Configure Hiera
  class { 'hiera':
    hierarchy => [
      '%{clientcert}',
      '%{environment}',
      'global',
    ],
    datadir      => '/etc/puppet/environments/%{environment}/hieradata',
    backends     => ['eyaml', 'yaml'],
    extra_config => join($hiera_eyaml_config, "\n"),
    notify       => Service['puppetmaster'],
  }

  ## Puppet master
  service { 'puppetmaster':
    ensure => 'running',
    enable => true,
  }

  ## Puppet agent
  service { 'puppet':
    ensure => 'running',
    enable => true,
  }

}
