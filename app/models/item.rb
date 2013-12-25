class Item < ActiveRecord::Base
  belongs_to :item_group
  belongs_to :item_type

  include ActiveUUID::UUID
  attr_accessible :item_group_id,:item_type_id,
                  :atk, :def, :description, :health,
                  :level, :name, :gold, :gem, :dam, :pc_atk, :pc_dam

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
end
