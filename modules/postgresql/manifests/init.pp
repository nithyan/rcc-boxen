# Public: Install and configure postgresql from homebrew.
#
# Examples
#
#   include postgresql
class postgresql {
  include postgresql::config
  include homebrew
  include sysctl

  file { [
    $postgresql::config::datadir,
    $postgresql::config::logdir,
  ]:
    ensure  => directory
  }

  file { '/Library/LaunchDaemons/dev.postgresql.plist':
    content => template('postgresql/dev.postgresql.plist.erb'),
    group   => 'wheel',
    notify  => Exec['Starting postgres service'],
    owner   => 'root'
  }

  sysctl::set { 'kern.sysv.shmmax':
    value => 1610612736
  }

  sysctl::set { 'kern.sysv.shmall':
    value => 393216
  }

  homebrew::formula { 'postgresql':
    before => Package['boxen/brews/postgresql'],
  }

  package { 'boxen/brews/postgresql':
    ensure => '9.2.4-boxen2',
    notify => Exec['Starting postgres service']
  }

  exec { 'init-postgresql-db':
    command => "initdb -E UTF-8 ${postgresql::config::datadir}",
    creates => "${postgresql::config::datadir}/PG_VERSION",
    require => Package['boxen/brews/postgresql']
  }

#  service { 'dev.postgresql':
#    ensure  => running,
#    require => Exec['init-postgresql-db']
#  }

  exec { "Starting postgres service":
    command => "pg_ctl -o '-p ${postgresql::config::port}' -D ${postgresql::config::datadir} -l ${postgresql::config::logdir}/server.log start",
    logoutput => true,
    require => Exec['init-postgresql-db']
  }


  service { 'com.boxen.postgresql': # replaced by dev.postgresql
    before => Exec['Starting postgres service'],
    enable => false
  }

  file { "${boxen::config::envdir}/postgresql.sh":
    content => template('postgresql/env.sh.erb'),
    require => File[$boxen::config::envdir]
  }

  $nc = "nc -z localhost ${postgresql::config::port}"

  exec { 'wait-for-postgresql':
    command  => "while ! ${nc}; do sleep 1; done",
    provider => shell,
    timeout  => 30,
    unless   => $nc,
    require  => Exec['Starting postgres service']
  }
}
