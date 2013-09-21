class rcc_setup::services{

  $rcc_project_src_directory = hiera('rcc_project_src_directory')
  $rcc_services_directory = hiera('rcc_services_directory')

  exec { "Executing maven in rcc services":
    command => "cd ${rcc_project_src_directory}/${rcc_services_directory} && mvn clean compile flyway:clean flyway:migrate install -Denv=dev",
    logoutput => true,
    onlyif => "ls ${rcc_project_src_directory}/${rcc_services_directory}"
  }
}