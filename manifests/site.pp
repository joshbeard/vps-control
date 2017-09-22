## site.pp ##

# This file (manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

# Make filebucket 'main' the default backup location for all File resources:
case $facts['kernel'] {
  'Linux': {
    File {
      backup                  => 'main',
      selinux_ignore_defaults => true,
      source_permissions      => 'ignore',
      group                   => 'root',
    }
    Exec {
      path => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    }
    $pkg_provider = undef
  }
  'FreeBSD': {
    $pkg_provider = 'pkgng'
    File {
      group => 'wheel',
    }
    Exec {
      path => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    }
  }
  default: {
    fail("This is not supported on $facts['kernel']")
  }
}

Package {
  provider => $pkg_provider,
}

Vcsrepo {
  provider => 'git',
}


# DEFAULT NODE
node default { }

# Set 'noop_mode' in Hiera to set systems to noop.
# This shouldn't be used to set systems in noop long-term.
# This needs the trlinklin-noop module
$noop_mode = lookup('noop_mode')
if $noop_mode == true {
    warning('noop_mode is enabled')
    noop()
}


# No longer supporting Puppet 3 in this control repo.  If we encounter a 3.x
# agent, fail.  We could handle upgrading, but it's likely not a scenario that
# we'll be encountering.
if versioncmp($::puppetversion, '4.0.0') >= 0 {

  # Workaround to permit compilation via puppet job run command
  # The $facts variable is always present in normal conditions.
  if defined('$facts') {

    # Include the base profile for a given OS
    $kernel_down=downcase($::kernel)

    #contain '::profile::base'
    #contain "::profile::base::${kernel_down}"

    # Classification option 1 - Profiles defined in Hiera
    # Looks for an array key called 'profiles' and includes them.
    lookup('classes', Array[String], 'unique', [] ).contain
    lookup('classes', Array[String], 'unique', [] ).each | $p | {
      #Class["::profile::base::${kernel_down}"] -> Class[$p]
      include $p
    }

    # Classification option 2 - Classic roles and profiles classes:
    #  if $::role and $::role != '' {
    #    contain "::role::${::role}"
    #    Class["::profile::base::${kernel_down}"] -> Class["::role::${::role}"]
    #  }
  } else {
    notice('Executed via puppet orchestrator')
  }
} else {
  fail('Puppet agents < version 4 are not supported')
}

