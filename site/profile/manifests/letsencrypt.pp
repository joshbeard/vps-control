#
# Letsencrypt
#
# TODO:
#   - work out ordering: using webroot for authenticating means we can't start
#     nginx until we have the cert.  but we need nginx running (80) to get the
#     cert.
#
class profile::letsencrypt (
  $domains           = {},
  $certonly_defaults = {},
) {

  include ::letsencrypt

  file { '/var/www/le_webroot':
    ensure => 'directory',
  }

  $domains.each |$domain, $params| {
    $params['webroot_paths'].each |$dir| {
      file { $dir:
        ensure => 'directory',
      }
    }
  }

  create_resources('letsencrypt::certonly', $domains, $certonly_defaults)

}
