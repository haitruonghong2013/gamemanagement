class AddLifeToCharacters < ActiveRecord::Migration
  def change
    add_column :characters,:life,:integer
  end
end
