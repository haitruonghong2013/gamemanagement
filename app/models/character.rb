class Character < ActiveRecord::Base
  include ActiveUUID::UUID
  has_many :scores
  belongs_to :user
  attr_accessible :atk1, :atk2, :atk3, :ban, :char_gender, :char_name, :char_race, :def, :gold, :hp, :lose_number, :lv, :medal, :mp, :online, :user_id, :win_number
end
