class UserItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :character


  include ActiveUUID::UUID
  attr_accessible :atk, :character_id, :def, :description, :health, :level, :name, :user_id
end
