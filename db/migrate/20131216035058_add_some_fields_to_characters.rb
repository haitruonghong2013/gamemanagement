class AddSomeFieldsToCharacters < ActiveRecord::Migration
  def change
    change_column :characters,:atk1,:float
    change_column :characters,:atk2,:float
    change_column :characters,:atk3,:float
    change_column :characters,:def,:float
  end
end
