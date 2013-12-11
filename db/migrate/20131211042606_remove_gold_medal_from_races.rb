class RemoveGoldMedalFromRaces < ActiveRecord::Migration
  def up
    remove_column :races,:gold
    remove_column :races,:medal
  end

  def down
    add_column :races,:gold,:integer
    add_column :races,:medal,:integer
  end
end
