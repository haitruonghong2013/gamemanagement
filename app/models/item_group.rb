class ItemGroup < ActiveRecord::Base
  has_many :items
  has_many :item_types
  include ActiveUUID::UUID
  attr_accessible :description, :name
end
