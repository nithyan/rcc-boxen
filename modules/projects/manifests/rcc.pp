class projects::rcc{
  include wget
  include java
  include maven
  include tomcat
  postgresql::user{"postgres superuser":
    user => "postgres",
    is_superuser => true
  }


  class { 'nodejs::global':
    version => 'v0.10'
  }
  nodejs::module { 'jslint' : node_version => 'v0.10' }
  nodejs::module { 'csslint' : node_version => 'v0.10' }
  exec { "Installing ember-tools":
    command => "npm install -g ember-tools",
    logoutput => true,
    require => Class['nodejs::global'],
    user => "root"
  }


  class { 'ruby::global':
    version => '1.9.3',
    require => Class['wget']
  }
  ruby::gem { "bundler for 1.9.3": gem     => 'bundler', ruby    => '1.9.3', version => '~> 1.2.0'}
  ruby::gem { "compass for 1.9.3": gem     => 'compass', ruby    => '1.9.3'}
  ruby::gem { "sass for 1.9.3":    gem     => 'sass', ruby    => '1.9.3'}
  ruby::plugin { 'rbenv-vars':
    ensure => 'v1.2.0',
    source  => 'sstephenson/rbenv-vars'
  }

  include rcc_setup
}