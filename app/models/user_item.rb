class UserItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :character
  belongs_to :item_group
  belongs_to :item_type


  include ActiveUUID::UUID
  attr_accessible :atk, :character_id, :def, :description, :health, :level, :name, :user_id,:item_group_id, :item_type_id

  def self.search(search)
    if search  and search.strip != ''
      joins(:character).where('characters.char_name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
