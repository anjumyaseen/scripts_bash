#!/bin/bash

pg_dumpall -v -U postgres_master -h pg01  -f /tmp/roles_backup.sql --no-role-passwords -g

