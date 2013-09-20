class projects::rcc{

  include git
  include wget
  include postgresql
  include wget
  include maven
  include tomcat


  class { 'nodejs::global':
    version => 'v0.10'
  }
  nodejs::module { 'jslint' : node_version => 'v0.10' }
  nodejs::module { 'csslint' : node_version => 'v0.10' }
  #  nodejs::module { 'ember-tools' : node_version => 'v0.10' }


  class { 'ruby::global':
    version => '1.9.3'
  }
  ruby::gem { "bundler for 1.9.3": gem     => 'bundler', ruby    => '1.9.3', version => '~> 1.2.0'}
  ruby::gem { "compass for 1.9.3": gem     => 'compass', ruby    => '1.9.3'}
  ruby::gem { "sass for 1.9.3":    gem     => 'sass', ruby    => '1.9.3'}
  ruby::plugin { 'rbenv-vars':
    ensure => 'v1.2.0',
    source  => 'sstephenson/rbenv-vars'
  }

}