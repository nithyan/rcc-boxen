class rcc_setup::repositories{

  $rcc_repositories = hiera('rcc_repositories')

  define clone_repositories(){
  $rcc_project_src_directory = hiera('rcc_project_src_directory')
  $rcc_git_url = hiera('rcc_git_url')

  repository { "${rcc_project_src_directory}/${name}":
    source => "${rcc_git_url}/${name}.git",
    protocol => 'https'
  }
  notify{"Repository: ${name} is cloned":
    require => Repository["${rcc_project_src_directory}/${name}"]}
  }

  clone_repositories{ $rcc_repositories :
    require => Class['git']
  }
}