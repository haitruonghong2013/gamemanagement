class UserItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :character
  belongs_to :item_group
  belongs_to :item_type
  belongs_to :item


  include ActiveUUID::UUID
  attr_accessible :character_id, :user_id, :item_group_id, :item_type_id,
                  :def, :description, :health, :level, :name,
                  :atk, :dam, :pc_atk, :pc_dam, :permanent, :cur_health, :item_id

  def as_json(options = {})
    {
        :item_type =>self.item_type.name,
        :thumb_path => (self.item.image_name.path ? options[:root_path].sub(/\/$/, '')+self.item.image_name.url(:thumb_128x128) : ''),
        :image_path => (self.item.image_name.path ? options[:root_path].sub(/\/$/, '')+self.item.image_name_url : ''),
        :buy_gold => self.item.gold,
        :buy_gem =>  self.item.gem,
        :id =>self.id,
        :name  => self.name,
        :atk => self.atk,
        :description => self.description,
        :def => self.def,
        :health => self.health,
        :level => self.level,
        :dam => self.dam,
        :pc_atk => self.pc_atk,
        :pc_dam => self.pc_dam,
        :permanent => self.permanent,
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
