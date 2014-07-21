class profile::gitolite {
  package { 'perl-Data-Dumper.x86_64':
    ensure => 'present',
  }

  class { '::gitolite':
    key_user     => 'admin',
    pubkey       => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPtIAa54bGh3ZvQkiy4OZ8iuUKJWsvctqc1yF5IlnhhbfzC50Bvl+oMALhH2n03hFmZm2LoRH2qSB1aebeNqL3Resf/9/IihYtFKkrTbaWQH6p2wai+dDj7VBHWhKOJztLZfGlDGogY7rxcFQBJZcdiLQvJPf8YCQReL5UbgJIeS4mV2xQjL6RriVsCKc6eg+PnROQ/rG85GdIhM6fmWrm4+Qu1lhq08i0BWqfLRnv5ZZ3XYsJoiz9QFwcEssbtgvmpAWYmcJorpEdkyQBpXfzGfI5NXaxalJ8An9awZyJzS1ROVeOXeJI6ZcRCgm51BQfzj77QA6Q82SUoCFfho+x josh@signalboxes.net',
    perl_package => 'perl-Time-HiRes',
    require      => Package['perl-Data-Dumper.x86_64'],
  }
}
