class AddPermanentToItems < ActiveRecord::Migration
  def change
    add_column :items, :permanent, :boolean
  end
end
