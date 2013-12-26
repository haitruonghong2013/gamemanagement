class AddGemToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :gem, :float
  end
end
