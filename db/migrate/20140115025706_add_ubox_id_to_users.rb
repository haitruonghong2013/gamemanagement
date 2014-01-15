class AddUboxIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ubox_id, :string
  end
end
