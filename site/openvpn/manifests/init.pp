class openvpn (
  $notify_exec,
) {

  contain ::openvpn::service
  include ::kmod

  kmod::load { 'tun':
  } ->
  package { 'openvpn':
    ensure => installed,
  } ->
  Service['openvpn']

}
