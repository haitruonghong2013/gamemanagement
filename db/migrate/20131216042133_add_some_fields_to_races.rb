class AddSomeFieldsToRaces < ActiveRecord::Migration
  def change
    change_column :races,:atk1,:float
    change_column :races,:atk2,:float
    change_column :races,:atk3,:float
    change_column :races,:def,:float
  end
end
