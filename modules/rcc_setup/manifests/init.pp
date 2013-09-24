class rcc_setup{

  include maven
  include tomcat
  include java

  include rcc_setup::repositories
  include rcc_setup::ui
  include rcc_setup::services

  Class[rcc_setup::repositories] -> Class[rcc_setup::ui] -> Class[rcc_setup::services]

}
