class Character < ActiveRecord::Base

  DEFAULT_ATTRS_VALUES = {
      :gold => 100,
      :medal => 0,
      :lv => 1,
      :lose_number => 0,
      :win_number => 0,
      :ban =>false
  }

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

  validates :char_name, :presence => true, :uniqueness => {:case_sensitive => false,:message =>'char_name is existing!'}
end
