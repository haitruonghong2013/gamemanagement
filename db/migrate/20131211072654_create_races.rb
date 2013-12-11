class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races,:id=>false do |t|
      t.uuid :id, :primary_key => true
      t.integer :atk1
      t.integer :atk2
      t.integer :atk3
      t.integer :def
      t.integer :hp
      t.integer :mp
      t.integer :char_race
      t.timestamps
    end
  end
end
