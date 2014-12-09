class fastd::gluonconfig (
  $fastd_public_key,
  $fastd_port,
  $fastd_community_folder,
) {
  $fastd_connection_ip = hiera('fastd_connection_ip')

  # in the future we will manage that with puppetdb
  file { "${fastd_community_folder}/fastd-router-snippet":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => 0600,
    content => template('fastd/fastd-router-snippet.erb'),
    require => File["${fastd_community_folder}"],
  }

}
