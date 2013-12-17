class Character < ActiveRecord::Base

  DEFAULT_ATTRS_VALUES = {
      :gold => 100,
      :medal => 0,
      :lv => 1,
      :lose_number => 0,
      :win_number => 0,
      :ban =>false,
      :life =>10
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
                  :life,                    #
                  :online,                #user online or not
                  :user_id,               #belong to an user
                  :win_number             #win batle game number

  validates :char_name, :presence => true, :uniqueness => {:case_sensitive => false,:message =>'char_name is existing!'}

  def self.search(search)
    if search  and search.strip != ''
      where('char_name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def as_json(options = {})
    {
        :id =>self.id,
        :atk1 => self.atk1,                  #Skill 1
        :atk2 => self.atk2,                  #Skill 2
        :atk3 => self.atk3,                  #Skill 3
        :ban => self.ban,                   #ban character
        :char_gender => self.char_gender,           #gender character
        :char_name => self.char_name,             #name character
        :char_race => self.char_race,             #
        :def => self.def,                   #defense number
        :gold => self.gold,                  #gold number
        :hp => self.hp,                    #blood number
        :lose_number => self.lose_number,           #lose batle game number
        :lv => self.lv,                    #level of character
        :medal => self.medal,                 #medal of character, earn medal to up character level
        :life => self.life,                    #
        #:online => self.online,                #user online or not
        :user_id => self.user_id,               #belong to an user
        :win_number => self.win_number,             #win batle game number
        :created_at => self.created_at.to_time.to_i,
        :updated_at => self.updated_at.to_time.to_i,
    }
  end
end
