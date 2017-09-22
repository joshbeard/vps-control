define profile::www::site (
  String           $site    = $title,
  Stdlib::Unixpath $docroot = "/var/www/${site}",
  Hash             $repo    = {},
  String           $group   = $::root_group,
  String           $user    = 'root',
) {

  $_repos_resource = { $title => $repo }

  $_repos_defaults = {
    ensure   => 'latest',
    provider => 'git',
    group    => $group,
    user     => $user,
    path     => "/var/www/${title}"
  }
  create_resources('vcsrepo', $_repos_resource, $_repos_defaults)

}
