#
# Very preliminary letsencrypt management
#
# TODO:
#   - manage installation and use certbot
#     - track upstream progress: https://github.com/danzilio/puppet-letsencrypt
#   - work out ordering: using webroot for authenticating means we can't start
#     nginx until we have the cert.  but we need nginx running (80) to get the
#     cert. standalone might be the way to go.  is this working on freebsd?
#   - move the certonly stuff to vhost-specific profiles
#   - manage cronjob that'll restart nginx only if a new cert was obtained.
#     the default cronjob restarted nginx even if a new cert was not obtained.
#
class profile::letsencrypt (
  $domains           = {},
  $certonly_defaults = {},
) {

  include ::letsencrypt

  create_resources('letsencrypt::certonly', $domains, $certonly_defaults)

}
