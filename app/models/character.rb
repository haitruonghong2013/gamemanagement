class Character < ActiveRecord::Base
  before_create :apply_some_default_values
  has_many :user_items

  DEFAULT_ATTRS_VALUES = {
      :gem => 0,
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
                  :win_number,             #win batle game number
                  :gem

  validates :char_name, :presence => true, :uniqueness => {:case_sensitive => false,:message =>'char_name is existing!'}

  def self.search(search)
    if search  and search.strip != ''
      where('char_name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def gold_ranking(after_time)
    if after_time  and after_time.strip != ''
      Character.count(:conditions => ['gold > ? and updated_at >= ?', self.gold, after_time])
    else
      Character.count(:conditions => ['gold > ?', self.gold])
    end
  end

  def level_ranking(after_time)
    if after_time  and after_time.strip != ''
      Character.count(:conditions => ['lv > ? and updated_at >= ?', self.lv, after_time])
    else
      Character.count(:conditions => ['lv > ?', self.lv])
    end
  end


  def apply_some_default_values
    #Use  Character default attributes
    self.medal = Character::DEFAULT_ATTRS_VALUES[:medal]
    self.lv = Character::DEFAULT_ATTRS_VALUES[:lv]
    self.gold = Character::DEFAULT_ATTRS_VALUES[:gold]
    self.gem = Character::DEFAULT_ATTRS_VALUES[:gem]
    self.lose_number = Character::DEFAULT_ATTRS_VALUES[:lose_number]
    self.win_number = Character::DEFAULT_ATTRS_VALUES[:win_number]
    self.ban = Character::DEFAULT_ATTRS_VALUES[:ban]
    self.life = Character::DEFAULT_ATTRS_VALUES[:life]

    if self.char_race
      select_race = Race.find_all_by_char_race(self.char_race).first
      if select_race
        self.atk1 = select_race.atk1
        self.atk2 = select_race.atk2
        self.atk3 = select_race.atk3
        self.def = select_race.def
        self.hp =  select_race.hp
        self.mp =  select_race.mp
      else
        #Use  Race default attributes
        self.atk1 = Race::DEFAULT_ATTRS_VALUES[:atk1]
        self.atk2 = Race::DEFAULT_ATTRS_VALUES[:atk2]
        self.atk3 = Race::DEFAULT_ATTRS_VALUES[:atk3]
        self.def = Race::DEFAULT_ATTRS_VALUES[:def]
        self.hp =  Race::DEFAULT_ATTRS_VALUES[:hp]
        self.mp =  Race::DEFAULT_ATTRS_VALUES[:mp]
      end
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
