class katellovirt::libvirt {
  class { '::libvirt':
    auth_tcp   => 'none',
    listen_tls => false,
    listen_tcp => true,
    sysconfig  => {
      'LIBVIRTD_ARGS' => '--listen',
    },
  } ->
  class { '::katellovirt::libvirt::storage': }

  $ip = {
    'address' => '192.168.100.1',
    'netmask' => '255.255.255.0',
  }
  ::libvirt::network { 'foreman':
    ensure       => 'enabled',
    autostart    => true,
    forward_mode => 'nat',
    forward_dev  => 'virbr1',
    ip           => [ $ip ],
  }

  sysctl { "net.ipv4.ip_forward":
    ensure => present,
    value  => "1",
  }

  shellvar { "IPTABLES_MODULES":
    ensure => present,
    target => "/etc/sysconfig/iptables-config",
    value  => "nf_conntrack_tftp nf_nat_tftp",
  } ~>
  Service['iptables']
}
