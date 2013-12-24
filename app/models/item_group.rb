class ItemGroup < ActiveRecord::Base
  has_many :items

  include ActiveUUID::UUID
  attr_accessible :description, :name
end
