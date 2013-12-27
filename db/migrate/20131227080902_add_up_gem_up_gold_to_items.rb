class AddUpGemUpGoldToItems < ActiveRecord::Migration
  def change
    add_column :items, :up_gem,:float
    add_column :items, :up_gold,:float
  end
end
