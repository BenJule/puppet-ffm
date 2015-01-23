class profiles::firewall (
  $purge = false,
  $batman_bridge,
  $route_traffic_through_vpn_tunnel = true,
  $vpn_interface,
) {

  if str2bool($purge) {
    resources { 'firewall':
      purge => true,
    }
  }

  class { '::firewall': }

  if $route_traffic_through_vpn_tunnel {
    firewall { '100 Mark Mesh VPN Traffic':
      provider => 'iptables',
      chain    => 'PREROUTING',
      table    => 'mangle',
      iniface  => $batman_bridge,
      proto    => 'all',
      jump     => 'MARK',
      set_mark => '0x1/0xffffffff',
    }
  }

  firewall { '001 Masquerade VPN Traffic':
    provider => 'iptables',
    chain    => 'POSTROUTING',
    table    => 'nat',
    outiface => $vpn_interface,
    proto    => 'all',
    jump     => 'MASQUERADE',
  }

}
