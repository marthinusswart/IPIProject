#! /bin/bash
# (exportdb.sh) run this script as root

pg_path=/usr/local/packages/pgsql_8.0.3
dat_path=/home/psnel/Projects/klient/IPI/db/data

# Tables to export
TABLES="Super_Construct
Construct
Question
Wording"

# export tables
for table in $TABLES
do
	# sql COPY commands to tmp file
	echo COPY $table TO \'$dat_path/exp_$table.dat\' > _tmpcp.sql
	# run the COPY cmd
	$pg_path/bin/psql fnctlint_ipi <  ./_tmpcp.sql
done

exit 0