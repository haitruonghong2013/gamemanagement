class Score < ActiveRecord::Base
  include ActiveUUID::UUID
  belongs_to :character
  belongs_to :user
  attr_accessible :character_id, :score, :time_stamp,:score_type
end
