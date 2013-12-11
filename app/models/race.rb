class Race < ActiveRecord::Base
  DEFAULT_ATTRS_VALUES = {
      :atk1 => 1,
      :atk2=> 1,
      :atk3=> 1,
      :def=> 1,
      :gold=> 1,
      :hp=> 1,
      :medal=> 1,
      :mp => 1
  }
  attr_accessible :atk1, :atk2, :atk3, :char_race, :def, :gold, :hp, :medal, :mp
end
