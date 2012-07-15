#! /bin/bash
# run this script as postgres db superuser

pg_path=/usr/local/packages/pgsql_8.0.3


# recreate db
#$pg_path/bin/dropdb IPI
#$pg_path/bin/createdb fnctlint_ipi

# run SQL DDL
$pg_path/bin/psql fnctlint_ipi < ./createdb.sql

exit 0
