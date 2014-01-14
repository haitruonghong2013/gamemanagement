class AddItemIdToUserItems < ActiveRecord::Migration
  def change
    add_column :user_items, :item_id, :uuid
  end
end
