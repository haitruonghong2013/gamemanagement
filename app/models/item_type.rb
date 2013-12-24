class ItemType < ActiveRecord::Base
  has_many :items
  has_many :user_items
  belongs_to :item_group

  include ActiveUUID::UUID
  attr_accessible :item_group_id,:description, :name
end
