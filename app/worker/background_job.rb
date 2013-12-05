class BackgroundJob
  def self.reminder_before_meeting
    puts "reminder_before_meeting run - #{Time.now}"
    puts "----------------------------------------"
    #Logic push notification happen next 30 minutes
    push_notifications = PushNotification.where("notif = ? and reminder_for_next_meeting = ? and device_id is not null and device_id != ''",true,true)
    push_notifications.each do |push_notification|
      user =  User.find(push_notification.user_id)
      #Time.zone = user.time_zone
      #Time.zone ='Hanoi'
      #puts "Time.zone #{Time.zone} - #{Time.zone.now}"
      meetings = Meeting.where('status = 0 and user_id = :user_id and  meeting_time <= :param1 and meeting_time >= :param2',
                               :user_id => push_notification.user_id,
                               :param1 => (Time.now.utc.in_time_zone(user.time_zone) + (push_notification.time_reminder/60 + 5).minutes).to_s,
                               :param2 => (Time.now.utc.in_time_zone(user.time_zone) + (push_notification.time_reminder/60 - 5).minutes).to_s
      )
      meetings.each do |meeting|
        APNS.send_notification(push_notification.device_id, :alert => "Next Meeting with client #{meeting.client.name} at #{meeting.meeting_time}",
                               :badge => 0,
                               :sound => 'default',
                               :other => {:type => 1,
                                          :meeting_id => meeting.id,
                                          :client_id => meeting.client.id}
        )
        puts "------- APNS.send_notification------- :"
        puts "Next Meeting with client #{meeting.client.name} at #{meeting.meeting_time}"
        puts "------- End ------------------------- :"

      end
      puts "----------------------------------------"
      #if meeting.user and meeting.user.push_notification and meeting.user.push_notification.device_id
      #  device_token = meeting.user.push_notification.device_id
      #else
      #  device_token = 'fce5197c11d5dbabb278240f56b2060e55b528076f24cedbf828c0d69ead7a6d'
      #end
    end
  end

  def self.reminder_late_meeting
    puts "reminder_late_meeting run - #{Time.now}"
    puts "----------------------------------------"
    push_notifications = PushNotification.where("notif = ? and device_id is not null and device_id != ''",true)
    push_notifications.each do |push_notification|
      user =  User.find(push_notification.user_id)
      meetings = Meeting.where('status = 0 and user_id = :user_id and  meeting_time <= :param1 and meeting_time >= :param2',
                               :user_id => push_notification.user_id,
                               :param1 => (Time.now.utc.in_time_zone(user.time_zone) - (30 -5).minutes).to_s,
                               :param2 => (Time.now.utc.in_time_zone(user.time_zone) - (30 + 5).minutes).to_s
      )
      meetings.each do |meeting|
        if push_notification.device_id
          APNS.send_notification(push_notification.device_id, :alert => "Late Meeting with client #{meeting.client.name} at #{meeting.meeting_time}",
                                 :badge => 0,
                                 :sound => 'default',
                                 :other => {:type => 3,
                                            :meeting_id => meeting.id,
                                            :client_id => meeting.client.id}
          )
          puts "------- APNS.send_notification------- :"
          puts "Late Meeting with client #{meeting.client.name} at #{meeting.meeting_time}"
          puts "------- End ------------------------- :"
        end
      end
    end
    puts "----------------------------------------"
  end

  def self.reminder_take_note
    puts "reminder_take_note run - #{Time.now}"
    puts "----------------------------------------"
    push_notifications = PushNotification.where("notif = ? and reminder_for_take_note = ? and device_id is not null and device_id != ''",true,true)
    push_notifications.each do |push_notification|
      user =  User.find(push_notification.user_id)
      #logger.info "#{push_notification.time_reminder/60}"
      #puts "#{push_notification.time_reminder/60}"
      meetings = Meeting.where('status = 2 and user_id = :user_id and  meeting_time <= :param1 and meeting_time >= :param2',
                               :user_id => push_notification.user_id,
                               :param1 => (Time.now.utc.in_time_zone(user.time_zone) - (push_notification.time_reminder/60 -5).minutes).to_s,
                               :param2 => (Time.now.utc.in_time_zone(user.time_zone) - (push_notification.time_reminder/60 + 5).minutes).to_s
      )
      meetings.each do |meeting|
        client_notes = ClientNote.where('meeting_id = ?',meeting.id)
        if client_notes.nil? or client_notes.length == 0
          #if push_notification.device_id
          APNS.send_notification(push_notification.device_id, :alert => "Take note Meeting with client #{meeting.client.name} at #{meeting.meeting_time}",
                                 :badge => 0,
                                 :sound => 'default',
                                 :other => {:type => 2,
                                            :meeting_id => meeting.id,
                                            :client_id => meeting.client.id}
          )
          puts "------- APNS.send_notification------- :"
          puts "Take note Meeting with client #{meeting.client.name} at #{meeting.meeting_time}"
          puts "------- End ------------------------- :"
          #end
        end
      end
    end
    puts "----------------------------------------"
  end
end