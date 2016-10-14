class profile::base::linux {
  include ::epel

  Package <<| provider == 'yum' |>>{
    require => Class['::epel'],
  }

  yumrepo { 'github_git-lfs':
    baseurl         => 'https://packagecloud.io/github/git-lfs/el/6/$basearch',
    repo_gpgcheck   => true,
    enabled         => true,
    gpgkey          => 'https://packagecloud.io/github/git-lfs/gpgkey',
    sslverify       => true,
    sslcacert       => '/etc/pki/tls/certs/ca-bundle.crt',
    metadata_expire => 300,
  }

  package { 'git-lfs':
    ensure  => 'latest',
    require => Yumrepo['github_git-lfs'],
  }
}
