class CreateUserItems < ActiveRecord::Migration
  def change
    create_table :user_items do |t|
      t.string :name
      t.text :description
      t.integer :level
      t.float :health
      t.float :atk
      t.float :def
      t.integer :user_id
      t.uuid :character_id

      t.timestamps
    end
  end
end
