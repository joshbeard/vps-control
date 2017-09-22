#
# Letsencrypt
#
# Manages the directories for the ACME challenge (.well_known) and a cron job for renewing.
#
class profile::letsencrypt (
  String           $email_address,
  String           $post_hook         = 'service nginx restart',
  Hash             $domains           = {},
  Hash             $certonly_defaults = {},
  Stdlib::Unixpath $web_root          = '/var/www/le_webroot',
  Optional[String] $owner             = undef,
  Optional[String] $group             = undef,
  String           $cron_user         = 'root',
  Array            $cron_hour         = [11, 23],
) {

  include ::letsencrypt

  file { 'letsencrypt_webroot':
    ensure => 'directory',
    path   => $web_root,
    owner  => $owner,
    group  => $group,
  }

  $domains.each |$domain, $params| {
    $params['webroot_paths'].each |$dir| {
      file { $dir:
        ensure => 'directory',
        owner  => $owner,
        group  => $group,
      }
    }
  }

  create_resources('letsencrypt::certonly', $domains, $certonly_defaults)

  cron { 'letsencrypt-renew':
    ensure      => 'present',
    command     => "certbot renew --post-hook '${post_hook}' -m ${email_address}",
    user        => $cron_user,
    minute      => '5',
    hour        => $cron_hour,
    environment => 'PATH=/bin:/usr/bin:/usr/sbin:/usr/local/bin',
  }

}
