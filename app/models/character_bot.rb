class CharacterBot < ActiveRecord::Base
  include ActiveUUID::UUID
  attr_accessible :atk1, :atk2, :atk3, :ban, :char_gender, :char_name, :char_race, :def, :gold, :hp, :lose_number, :lv, :medal, :mp, :online, :win_number
end
