#!/bin/bash

date=$(date +%F)
backupDir="{{mongo_backup_path}}${date}/"
mkdir -p "${backupDir}"
# Dump all except gridfs
mongodump --db "{{mongo_backup_db}}" \
  {{'--gzip ' if mongo_backup_gzip == true else ''}}--out "${backupDir}" \
  --excludeCollection 'fs.files' \
  --excludeCollection 'fs.chunks'
# Dump only gridfs and always without gzip
mongodump --db "{{mongo_backup_db}}" \
  --out "${backupDir}" \
  --collection 'fs.files'
mongodump --db "{{mongo_backup_db}}" \
  --out "${backupDir}" \
  --collection 'fs.files' \
  --collection 'fs.chunks'
