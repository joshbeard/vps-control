class profile::smb {

  class { '::samba::server':
    manage_firewall => false,
  }

  samba::server::share { 'media':
    share_name      => 'media',
    share_path      => '/store/media',
    share_writeable => 'yes',
    share_public    => 'no',
  }
}
