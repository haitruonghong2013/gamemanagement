class AddDamPcDamPcAtkToItems < ActiveRecord::Migration
  def change
    add_column :items, :dam, :float
    add_column :items, :pc_dam, :float
    add_column :items, :pc_atk, :float
  end
end
