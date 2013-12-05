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

set :environment, 'development'
set :output, {
    :error    => "/home/administrator/rails_projects/cs-201310-ipad-app-web/log/error.log",
    :standard => "/home/administrator/rails_projects/cs-201310-ipad-app-web/log/cron.log"
}
#every 1.minute do
#  #runner "Post.test_update"
#  runner "BackgroundJob.push_notification_when"
#  #command "echo 'you can use raw cron syntax too'"
#end

every 5.minute do
  #runner "Post.test_update"
  runner "BackgroundJob.reminder_before_meeting"
  runner "BackgroundJob.reminder_late_meeting"
  runner "BackgroundJob.reminder_take_note"
  #command "echo 'you can use raw cron syntax too'"
end



