class katellovirt::libvirt::storage {
  include ::libvirt::params

  Exec {
    cwd => '/',
    path => '/bin:/usr/bin',
    user => 'root',
    provider => 'posix',
    require => Service[$::libvirt::params::libvirt_service],
  }

  $pool_name = 'default'
  $storage_file = "/etc/libvirt/storage/${pool_name}.xml"
  $autostart_file = "/etc/libvirt/storage/autostart/${pool_name}.xml"
  $content = template('katellovirt/storage.xml.erb')
  file { "/etc/libvirt/storage":
    ensure => directory,
  } ->
  file { $storage_file:
    content => $content,
    owner   => 'root',
    group   => 'root',
    mode    => 0600,
    replace => false,
  } ->
  exec { "virsh-pool-define-${pool_name}":
    command => "virsh pool-define ${storage_file}",
    unless => "virsh -q pool-list --all | grep -Eq '^\s*${pool_name}'",
  } ->
  exec { "virsh-pool-autostart-${pool_name}":
    command => "virsh pool-autostart ${pool_name}",
    creates => $autostart_file,
  } ->
  exec { "virsh-pool-start-${pool_name}":
    command => "virsh pool-start ${pool_name}",
    unless => "virsh -q pool-list --all | grep -Eq '^\s*${pool_name}\\s+active'",
  }
}
