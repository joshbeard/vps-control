class profile::base::linux {
  include ::epel

  Package <<| provider == 'yum' |>>{
    require => Class['::epel'],
  }
}
