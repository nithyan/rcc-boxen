# PostgreSQL Puppet Module for Boxen

[![Build Status](https://travis-ci.org/boxen/puppet-postgresql.png?branch=master)](https://travis-ci.org/boxen/puppet-postgresql)

## Usage

```puppet
# install postgres and run the service
include postgresql

# do the above automatically, and create a db
postgresql::db { 'mydb': }
```

# do the above automatically, and create a db
postgresql::db { "user creation":
 user => "username",
 is_superuser => true
}
```

## Required Puppet Modules

* `boxen`
* `homebrew`
* `stdlib`
* `sysctl`

*Note: Boxen runs most services on non-standard ports as to not collide with existing local installs. Boxen Postgresql runs on standard 5432.*

Then write some code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.
