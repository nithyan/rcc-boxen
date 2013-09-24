# Creates a new postgresql database.
#
# Usage:
#
#     postgresql::user { 'mydb': }
define postgresql::user($user, $is_superuser = true) {
  require postgresql
  if $is_superuser {
     $super_user_option = "-s"
  }
  else {
    $super_user_option = ""
  }

  exec { "postgresql-user-${user}":
    command => "createuser ${user} ${super_user_option}",
    require => Exec['wait-for-postgresql']
    unless => "psql postgres -tAc \"SELECT 1 FROM pg_roles WHERE rolname='$user'\""
  }
}
