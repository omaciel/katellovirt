class katellovirt::firewall::katello {
  firewall { '200 accept AMQP TCP':
    port   => 5671,
    proto  => tcp,
    action => accept,
  }
}
