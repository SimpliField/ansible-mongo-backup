#!/bin/bash

date=$(date +%F)
backupDir="{{mongo_backup_path}}${date}/"
[ -z "$1" ] && echo "Missing param" && exit 1 
database=$1

mkdir -p "${backupDir}"
# Dump all except gridfs
mongodump --db "${database}" \
  {{'--gzip ' if mongo_backup_gzip == true else ''}}--out "${backupDir}" \
  --excludeCollection 'fs.files' \
  --excludeCollection 'fs.chunks'
# Dump only gridfs and always without gzip
mongodump --db "${database}" \
  --out "${backupDir}" \
  --collection 'fs.files'
mongodump --db "${database}" \
  --out "${backupDir}" \
  --collection 'fs.chunks'
