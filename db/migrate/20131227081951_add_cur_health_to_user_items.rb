class AddCurHealthToUserItems < ActiveRecord::Migration
  def change
    add_column :user_items, :cur_health,:float
  end
end
