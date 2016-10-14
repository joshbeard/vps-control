class profile::base::linux {
  include ::epel
  include ::packagecloud

  Package <<| provider == 'yum' |>>{
    require => Class['::epel'],
  }

  packagecloud::repo { 'github/git-lfs':
   type => 'rpm',
  }

  package { 'git-lfs':
    ensure  => 'latest',
    require => Packagecloud::Repo['github/git-lfs'],
  }
}
