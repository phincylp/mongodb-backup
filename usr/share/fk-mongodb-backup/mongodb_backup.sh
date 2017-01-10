curr_date=$(date +%Y%m%d-%H%M)
db_backup_dir_path="$1"
db_backup_dir_curr=$db_backup_dir_path/$curr_date
mkdir -p $db_backup_dir_curr
/usr/share/fk-mongodb/lib/mongodump -o $db_backup_dir_curr -db $2
cd $db_backup_dir_path
tar -cvzf $curr_date.tar.gz $curr_date
rm -rf $curr_date

