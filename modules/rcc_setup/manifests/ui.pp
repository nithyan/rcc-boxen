class rcc_setup::ui{

$rcc_project_src_directory = hiera('rcc_project_src_directory')
$rcc_ui_directory = hiera('rcc_ui_directory')

exec { "Executing ant in rcc ui":
  command => "cd ${rcc_project_src_directory}/${rcc_ui_directory} && ant",
  logoutput => true,
  onlyif => "ls ${rcc_project_src_directory}/${rcc_ui_directory}"
}
}