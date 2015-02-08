define openvpn::ipredator (
  $vpn_routing_table,
  $username,
  $password,
  $dependent_services,
) {
  include ::openvpn

  validate_array($dependent_services)

  $interface   = $name
  $provider    = 'ipredator'
  $config_path = "/etc/openvpn/${name}"

  file { "/etc/openvpn/${name}.conf":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("openvpn/${provider}.conf.erb"),
    notify  => Service['openvpn'],
    require => Package['openvpn'],
  }

  file { "/etc/openvpn/${name}.auth":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("openvpn/${provider}.auth.erb"),
    notify  => Service['openvpn'],
    require => Package['openvpn'],
  }

  file { $config_path:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Package['openvpn'],
  } ->
  file { "${config_path}/${name}-up":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0754',
    content => template('openvpn/openvpn-up.erb'),
    notify  => Service['openvpn'],
  } ->
  file { "${config_path}/${name}-down":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0754',
    content => template('openvpn/openvpn-down.erb'),
    notify  => Service['openvpn'],
  }

  exec { "check for ${interface}":
    command => 'true', # please keep it there as a command, not as a bool
    unless  => "ifconfig | grep ${interface}",
    notify  => Service['openvpn'],
  }

}
