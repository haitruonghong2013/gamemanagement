class AddPermanentToUserItems < ActiveRecord::Migration
  def change
    add_column :user_items, :permanent, :boolean
  end
end
