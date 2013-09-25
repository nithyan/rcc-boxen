class rcc_setup::tomcat_environment_setup{

  include rcc_setup::params
  $tomcat_home = $rcc_setup::params::tomcat_home

  file { "${boxen::config::home}/tomcat_env.sh":
    content => template('rcc_setup/tomcat_env.sh.erb'),
    mode    => '0755',
  }

  file { "${rcc_setup::params::tomcat_home}/conf/tomcat-users.xml":
    content => template('rcc_setup/tomcat-users.xml.erb'),
    mode    => '0755',
    require => Class['java', 'tomcat']
  }

  exec {"Restarting Tomcat":
    command => "${rcc_setup::params::tomcat_home}/bin/catalina.sh stop && ${rcc_setup::params::tomcat_home}/bin/catalina.sh start",
    logoutput => true,
    environment => [ "TOMCAT_HOME=${rcc_setup::params::tomcat_home}", "CATALINA_HOME=${rcc_setup::params::tomcat_home}",
                      "CATALINA_BASE=${rcc_setup::params::tomcat_home}" ],
    require => File["${rcc_setup::params::tomcat_home}/conf/tomcat-users.xml"]

  }
}