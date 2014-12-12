class profiles::apt {

  include ::apt

  ::apt::source { 'universe-factory':
    comment           => 'universe-factory repository for Freifunk',
    location          => 'http://repo.universe-factory.net/debian/',
    release           => 'sid',
    repos             => 'main',
    key               => '16EF3F64CB201D9C',
    key_server        => 'pgp.mit.edu',
    include_src       => false,
    include_deb       => true
  }

  if $::operatingsystem == 'Ubuntu' and $::operatingsystemrelease == '14.04' {
    file { '/etc/apt/preferences.d/batman.pref':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => 0644,
      source  => 'puppet:///modules/profiles/trusty_batman.pref',
    } -> ::apt::source { 'utopic':
      comment           => 'ubuntu utopic',
      location          => 'http://de.archive.ubuntu.com/ubuntu/',
      release           => 'utopic',
      repos             => 'main universe',
      include_src       => true,
      include_deb       => true
    }
  }

}
