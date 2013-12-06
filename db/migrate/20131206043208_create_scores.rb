class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores,:id=>false do |t|
      t.uuid :id, :primary_key => true
      t.integer :user_id
      t.uuid :character_id
      t.timestamp :time_stamp
      t.float :score

      t.timestamps
    end
  end
end
