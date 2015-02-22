##
## Profile for configuring the Puppet agent and master on the vps
##
class profile::puppet {

  Ini_setting {
    ensure  => 'present',
    path    => "${::settings::confdir}/puppet.conf",
    section => 'main',
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
    ip     => $::ipaddress,
  }

  file { 'environments':
    ensure => 'directory',
    owner  => 'root',
    group  => 0,
    mode   => '0755',
    path   => "${::settings::confdir}/environments",
  }

  ## Configure r10k
  class { 'r10k':
    version       => 'latest',
    sources       => {
      'control'   => {
        'remote'  => 'https://github.com/joshbeard/vps-control.git',
        'basedir' => "${::settings::confdir}/environments",
        'prefix'  => false,
      }
    },
    purgedirs         => [ "${::settings::confdir}/environments" ],
    manage_modulepath => false,
    mcollective       => false,
    require           => File['environments'],
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
    hiera_yaml   => "${::settings::confdir}/hiera.yaml",
    confdir      => $::settings::confdir,
    datadir      => "${::settings::confdir}/environments/%{environment}/hieradata",
    backends     => ['eyaml', 'yaml'],
    extra_config => join($hiera_eyaml_config, "\n"),
  }

  cron { 'puppet':
    ensure  => 'present',
    command => "/usr/bin/env r10k deploy environment -pv ; /usr/bin/env puppet apply ${::settings::confdir}/environments/${::environment}/manifests/site.pp --environment ${::environment}",
    user    => 'root',
    minute  => '40',
  }


}
