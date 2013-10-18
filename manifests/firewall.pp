class katellovirt::firewall {
  resources { "firewall":
    purge => true
  }
  Firewall {
    before  => Class['::katellovirt::firewall::post'],
    require => Class['::katellovirt::firewall::pre'],
  }
  class { ['::katellovirt::firewall::pre',
           '::katellovirt::firewall::katello',
           '::katellovirt::firewall::provisioning',
           '::katellovirt::firewall::post']: }
  class { '::firewall': }
}
