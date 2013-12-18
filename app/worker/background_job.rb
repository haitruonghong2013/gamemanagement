class BackgroundJob
  def self.reset_character_life
    puts "reset_character_life run - #{Time.now}"
    puts "----------------------------------------"
    characters = Character.all
    #Logic push notification happen next 30 minutes
    characters.each do |character|
        character.life = Character::DEFAULT_ATTRS_VALUES[:life]
        character.save
        puts "------- #{character.char_name}------- :"
        puts "Reset Life to : #{character.life}------- :"

      end
    puts "------- End -------------------------"
      #if meeting.user and meeting.user.push_notification and meeting.user.push_notification.device_id
      #  device_token = meeting.user.push_notification.device_id
      #else
      #  device_token = 'fce5197c11d5dbabb278240f56b2060e55b528076f24cedbf828c0d69ead7a6d'
      #end
  end
end