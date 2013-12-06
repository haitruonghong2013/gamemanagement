class Character < ActiveRecord::Base
  include ActiveUUID::UUID
  has_many :scores
  belongs_to :user
  attr_accessible :atk1,                  #Skill 1
                  :atk2,                  #Skill 2
                  :atk3,                  #Skill 3
                  :ban,                   #ban character
                  :char_gender,           #gender character
                  :char_name,             #name character
                  :char_race,             #
                  :def,                   #defense number
                  :gold,                  #gold number
                  :hp,                    #blood number
                  :lose_number,           #lose batle game number
                  :lv,                    #level of character
                  :medal,                 #medal of character, earn medal to up character level
                  :mp,                    #
                  :online,                #user online or not
                  :user_id,               #belong to an user
                  :win_number             #win batle game number
end
