class UserItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :character
  belongs_to :item_group
  belongs_to :item_type


  include ActiveUUID::UUID
  attr_accessible :character_id, :user_id, :item_group_id, :item_type_id,
                  :def, :description, :health, :level, :name, :atk, :dam, :pc_atk, :pc_dam, :permanent

  def as_json(options = {})
    {
        :name  => self.name,
        :atk => self.atk,
        :description => self.description,
        :def => self.def,
        :health => self.health,
        :level => self.level,
        :dam => self.country,
        :pc_atk => self.cover,
        :pc_dam => self.created_date,
        :permanent => self.email,
        :updated_at => self.updated_at,
        :created_at => self.created_at
    }
  end

  def self.search(search)
    if search and search.strip != ''
      joins(:character).where('characters.char_name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
