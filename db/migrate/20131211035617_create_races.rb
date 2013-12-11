class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.integer :gold
      t.integer :atk1
      t.integer :atk2
      t.integer :atk3
      t.integer :def
      t.integer :hp
      t.integer :mp
      t.integer :medal
      t.integer :char_race

      t.timestamps
    end
  end
end
