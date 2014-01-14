class Item < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  DEFAULT_ATTRS_VALUES = {
      :name  => '',
      :atk => 0,
      :description => '',
      :gem =>0,
      :gold =>0,
      :image_path => '',
      :def => 0,
      :health => 0,
      :level => 1,
      :dam => 0,
      :pc_atk => 0,
      :pc_dam => 0,
      :up_gem => 0,
      :up_gold => 0
  }
  before_create :apply_some_default_values
  belongs_to :item_group
  belongs_to :item_type
  has_one :user_item

  include ActiveUUID::UUID

  mount_uploader :image_name, ImageUploader
  attr_accessible :item_group_id,:item_type_id,:image_name_cache,
                  :atk, :def, :description, :health,:image_name,
                  :level, :name, :gold, :gem, :dam, :pc_atk,
                  :pc_dam, :permanent, :up_gem, :up_gold

  validates :name, :presence => {:message => "This field is required."}
  #validates :image_name, :presence => {:message => "This field is required."}

  def self.search(search, item_group, item_type)
    result = self
    if item_group and item_group.strip != ''
      item_group = UUIDTools::UUID.parse(item_group)
      result = result.where('item_group_id = ?', item_group)

    end

    if item_type and item_type.strip != ''
      item_type = UUIDTools::UUID.parse(item_type)
      result = result.where('item_type_id = ?', item_type)
    end

    if search  and search.strip != ''
      result = result.where('items.name LIKE ?', "%#{search}%")
    end

    if item_group.blank? and item_type.blank? and search.blank?
      result = scoped
    end
    return result
  end

  def as_json(options = {})
    {
        :id =>self.id,
        :name  => self.name,
        :atk => self.atk,
        :description => self.description,
        :gem =>self.gem,
        :gold =>self.gold,
        :thumb_path => (self.image_name.path ? options[:root_path].sub(/\/$/, '')+self.image_name.url(:thumb_128x128) : ''),
        :image_path => (self.image_name.path ? options[:root_path].sub(/\/$/, '')+self.image_name_url : ''),
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

  def apply_some_default_values
    if self.gem.nil? or self.gem.blank?
      self.gem = Item::DEFAULT_ATTRS_VALUES[:gem]
    end
    if self.gold.nil? or self.gold.blank?
      self.gold = Item::DEFAULT_ATTRS_VALUES[:gold]
    end
    if self.atk.nil? or self.atk.blank?
      self.atk = Item::DEFAULT_ATTRS_VALUES[:atk]
    end
    if self.def.nil? or self.def.blank?
      self.def = Item::DEFAULT_ATTRS_VALUES[:def]
    end
    if self.health.nil? or self.health.blank?
      self.health = Item::DEFAULT_ATTRS_VALUES[:health]
    end
    if self.level.nil? or self.level.blank?
      self.level = Item::DEFAULT_ATTRS_VALUES[:level]
    end
    if self.dam.nil? or self.dam.blank?
      self.dam = Item::DEFAULT_ATTRS_VALUES[:dam]
    end
    if self.pc_atk.nil? or self.pc_atk.blank?
      self.pc_atk = Item::DEFAULT_ATTRS_VALUES[:pc_atk]
    end
    if self.pc_dam.nil? or self.pc_dam.blank?
      self.pc_dam = Item::DEFAULT_ATTRS_VALUES[:pc_dam]
    end
    if self.up_gem.nil? or self.up_gem.blank?
      self.up_gem = Item::DEFAULT_ATTRS_VALUES[:up_gem]
    end
    if self.up_gold.nil? or self.up_gold.blank?
      self.up_gold = Item::DEFAULT_ATTRS_VALUES[:up_gold]
    end
  end
end
