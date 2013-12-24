class ItemType < ActiveRecord::Base
  belongs_to :item_group

  include ActiveUUID::UUID
  attr_accessible :item_group_id,:description, :name
end
