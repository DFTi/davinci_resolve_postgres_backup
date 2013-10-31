# Postgres backup

## Mac OS X Setup

* Add setup passwordless pgdump access using ~/.pgpass
* Make sure it works by running `./backup.rb` and ensuring it writes a dump file
* Determine an interval for backup using the [cron syntax](http://www.webenabled.com/sites/default/files/crontab-syntax.gif)
  - e.g. nightly: `0 3 * * * /path/to/backup.rb`
* Open cron: `crontab -e`
* Insert the cron code and save the file
* Verify with `crontab -l

## Compression And Restore

It will already be dumped compressed. Commands being used under the hood:

```
# dump the database in custom-format archive
pg_dump -Fc mydb > db.dump

# restore the database
pg_restore -d newdb db.dump
```

# Reference

http://www.thegeekstuff.com/2009/01/how-to-backup-and-restore-postgres-database-using-pg_dump-and-psql/
http://stackoverflow.com/questions/2893954/how-to-pass-in-password-to-pg-dump
