class Item < ActiveRecord::Base
  belongs_to :item_group

  include ActiveUUID::UUID
  attr_accessible :atk, :def, :description, :health, :item_group_id, :level, :name
end
