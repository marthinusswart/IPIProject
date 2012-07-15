#! /bin/bash
# (copyExp.sh) run this script as postgres db superuser

dat_path=/home/psnel/Projects/klient/IPI/db/data
share_path=/home/psnel/mnt/XAVIER/_MAJESTY/z#tmp/data/ipi

# Tables to export
TABLES="Super_Construct
Construct
Question
Wording"

# copy exports
for table in $TABLES
do	
	# copy the file to share dir
	echo Copying $dat_path/exp_$table.dat  TO  $share_path/
	cp -f $dat_path/exp_$table.dat $share_path/
done

exit 0