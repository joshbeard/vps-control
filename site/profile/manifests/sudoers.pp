class profile::sudoers {
  $sudoers = hiera('sudoers',{})
  create_resources('::sudo::sudoers', $sudoers)
}
