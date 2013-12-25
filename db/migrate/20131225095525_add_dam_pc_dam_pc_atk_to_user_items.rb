class AddDamPcDamPcAtkToUserItems < ActiveRecord::Migration
  def change
    add_column :user_items, :dam, :float
    add_column :user_items, :pc_dam, :float
    add_column :user_items, :pc_atk, :float
  end
end
