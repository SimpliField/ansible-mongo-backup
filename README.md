Mongo backup
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
```

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

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
