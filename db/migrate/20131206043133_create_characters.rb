class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters, :id => false do |t|
      t.uuid :id, :primary_key => true
      t.integer :user_id
      t.string :char_name
      t.integer :gold
      t.integer :lv
      t.integer :atk1
      t.integer :atk2
      t.integer :atk3
      t.integer :def
      t.integer :hp
      t.integer :mp
      t.integer :medal
      t.boolean :char_gender
      t.integer :char_race
      t.boolean :online
      t.boolean :ban
      t.integer :win_number
      t.integer :lose_number

      t.timestamps
    end
    add_index :characters,:id
  end
end
