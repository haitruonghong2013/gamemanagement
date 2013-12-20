# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
rails_root = File.dirname(__FILE__) + '/..'
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

set :environment, 'development'
#set :environment, 'production'
set :output, {
    :error    => "#{rails_root}/log/error.log",
    :standard => "#{rails_root}/log/cron.log"
}
#every 1.minute do
#  #runner "Post.test_update"
#  runner "BackgroundJob.push_notification_when"
#  #command "echo 'you can use raw cron syntax too'"
#end

#every 1.minute do
#  #runner "Post.test_update"
#  runner "BackgroundJob.reset_character_life"
#  #runner "BackgroundJob.reminder_late_meeting"
#  #runner "BackgroundJob.reminder_take_note"
#  #command "echo 'you can use raw cron syntax too'"
#end

#script/rails runner -e production 'BackgroundJob.reset_character_life' >> config/../log/cron.log 2>> config/../log/error.log
every 1.day, :at => '12:00 am' do
  runner "BackgroundJob.reset_character_life"
end




