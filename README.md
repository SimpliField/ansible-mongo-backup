Mongo backup [![Build Status](https://travis-ci.org/SimpliField/ansible-mongo-backup.svg?branch=master)](https://travis-ci.org/SimpliField/ansible-mongo-backup) [![Ansible Role](https://img.shields.io/ansible/role/9796.svg?maxAge=2592000)](https://galaxy.ansible.com/SimpliField/mongo-backup/)
=========

Setup daily mongodb backups

Requirements
------------

Need ansible 2+

Role Variables
--------------

```yaml
mongo_backup_path: "/data/db/backups/"
mongo_backup_db: ""
mongo_backup_hour: "0"
mongo_backup_minute: "5"
mongo_backup_gzip: false
```

Dependencies
------------

There is no dependencies.
OFC Mongodb should be installed !

Example Playbook
----------------

```yaml
- hosts: servers
  roles:
  - { role: simplifield.mongo_backup, mongo_backup_db: dev_db }
```

License
-------

BSD
