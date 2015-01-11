# vim: set sw=2 sts=2 et tw=80 :
class dnsmasq (
  $auth_servers = [ '85.214.20.141', '213.73.91.35' ],
  $dns_interfaces,
  $no_dhcp_interface,
  $listen_address,
  $vpn_interface,
) {

  include ::dnsmasq::service

  package { 'dnsmasq':
  } ->
  file { '/etc/dnsmasq.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('dnsmasq/dnsmasq.conf.erb'),
    notify  => Service['dns'],
  } ->
  file { '/etc/dnsmasq.d/rules':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('dnsmasq/rules.erb'),
    notify  => Service['dns'],
  } ->
  Service['dns']

}
