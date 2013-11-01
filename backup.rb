#!/usr/bin/env ruby

# Name of database to backup
DATABASE = "bay02"

# Where you want .backup files to get created
DUMP_DIR = "/Volumes/BAY02RAID/Dropbox/Bay02/patrick_backup/PG_Dumps"

# Number of days to keep .backup file before deleting
MAX_DAYS_OLD = 30

# --- don't edit below this line

require 'logger'
require 'fileutils'
HERE = File.expand_path(File.dirname(__FILE__))
LOGPATH = File.join(HERE, "backup.log")
LOG = Logger.new(LOGPATH)

unless File.directory? DUMP_DIR
  FileUtils.mkdir(DUMP_DIR)
end

def time_stamped_file(file)
  file.gsub(/\./,"_" + Time.now.strftime("%m-%d_%H-%M-%S") + '.') 
end

def dump
  file = File.join(DUMP_DIR, time_stamped_file("#{DATABASE}.backup"))
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

def prune
  # Delete any backups over MAX_DAYS_OLD in DUMP_DIR
  LOG.warn "Pruning has not been implemented yet"
end

dump
prune
