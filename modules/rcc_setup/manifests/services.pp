class rcc_setup::services{

  include rcc_setup::params
  include rcc_setup::tomcat_environment_setup

  $rcc_project_src_directory = hiera('rcc_project_src_directory')
  $rcc_services_directory = hiera('rcc_services_directory')
  $tomcat_home=$rcc_setup::params::tomcat_home

  exec { "Executing maven in rcc services":
    command => "cd ${rcc_project_src_directory}/${rcc_services_directory} && mvn clean compile flyway:clean flyway:migrate tomcat:redeploy install -Denv=test",
    logoutput => true,
    onlyif => "ls ${rcc_project_src_directory}/${rcc_services_directory}",
    environment => [ "TOMCAT_HOME=${tomcat_home}", "CATALINA_HOME=${tomcat_home}", "CATALINA_BASE=${tomcat_home}" ],
    require => Class['maven','rcc_setup::tomcat_environment_setup']
  }
}