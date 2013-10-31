#!/usr/bin/env ruby
require 'logger'
require 'fileutils'

DATABASE = "bay02"
DIR = File.expand_path(File.dirname(__FILE__))
LOGPATH = File.join(DIR, "backup.log")
LOG = Logger.new(LOGPATH)

STDOUT.puts("Logging to #{LOGPATH}...")

DUMP_DIR = "/Volumes/BAY02RAID/Dropbox/Bay02/patrick_backup/PG_Dumps"

unless File.directory? DUMP_DIR
  FileUtils.mkdir(DUMP_DIR)
end

def dump
  file = File.join(DUMP_DIR, "#{DATABASE}.psql.dump")
  LOG.info("Started backup of #{DATABASE} into #{file}")
  command = "pg_dump -Fc -U postgres #{DATABASE} -f #{file} -h localhost"
  if system(command)
    LOG.info("Succeeded!")
  else
    LOG.error("Failed! Command was: #{command}")
  end
end

def restore(dumpfile)
  system("pg_restore -d #{DATABASE} #{dumpfile}")
end

dump
