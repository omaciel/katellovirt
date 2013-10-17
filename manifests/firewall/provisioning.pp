class katellovirt::firewall::provisioning {
  firewall { '100 accept http/https':
    port   => [80, 443],
    proto  => tcp,
    action => accept,
  }

  firewall { '110 accept puppet':
    port   => 8140,
    proto  => tcp,
    action => accept,
  }

  firewall { '120 accept DHCP':
    port   => [67, 68],
    proto  => udp,
    action => accept,
  }

  firewall { '125 accept TFTP':
    port   => 69,
    proto  => udp,
    action => accept,
  }

  firewall { '130 accept DNS TCP':
    port   => 53,
    proto  => tcp,
    action => accept,
  }

  firewall { '131 accept DNS UDP':
    port   => 53,
    proto  => udp,
    action => accept,
  }
}
