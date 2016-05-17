#!/bin/bash

date=$(date +%F)
backupDir="{{mongo_backup_path}}${date}/"
mkdir -p "${backupDir}"
mongodump --db "{{mongo_backup_db}}" --out "${backupDir}"
