#!/bin/bash

#pg_dump -v -c -U postgres_master -h pg01 -w -Ft ccmsi > /temp-pg02/ccmsi_backup_02012023.tar

#pg_dump -h pg01 -p 5432 -U postgres_master -Fc -b -v -f /temp-pg02/ccmsi.sql -j 2 -d ccmsi

pg_dump -v -c -U postgres_master -h pg01 -w ccmsi | gzip > /temp-pg02/ccmsi_backup.sql.gz

echo -e "Backup Completed"
