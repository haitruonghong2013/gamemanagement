class AddSomeFieldsToCharacterBots < ActiveRecord::Migration
  def change
    change_column :character_bots,:atk1,:float
    change_column :character_bots,:atk2,:float
    change_column :character_bots,:atk3,:float
    change_column :character_bots,:def,:float
  end
end
