class rcc_setup{

  include rcc_setup::repositories
  include rcc_setup::ui

  Class[rcc_setup::repositories] -> Class[rcc_setup::ui]

}