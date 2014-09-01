class profile::sudoers {
  $sudoers = hiera('sudo::sudoers',{})
  create_resources('::sudo::sudoers', $sudoers)
}
