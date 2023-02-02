# frozen_string_literal: true

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever


env :PATH, ENV['PATH']

set :output, './log/cron.log'

## Descoment this to test the load and run the following codes in your terminal
## crontab -r
## whenever --update-crontab --set environment='development'
# every 1.minute do
#   runner "puts 'Load the mystery lunches from ....'"
#   runner "ManagerLunch::MysteryLunchesMonth.call"
# end

every '0 1 1 * *' do
  runner "puts 'Load the mystery lunches from ....'"
  runner 'ManagerLunch::MysteryLunchesMonth.call'
end
