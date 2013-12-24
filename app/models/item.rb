class Item < ActiveRecord::Base
  belongs_to :item_group
  belongs_to :item_type

  include ActiveUUID::UUID
  attr_accessible :atk, :def, :description, :health, :item_group_id, :level, :name, :gold, :gem,:item_type_id
end
