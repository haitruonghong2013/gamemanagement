class CreateItems < ActiveRecord::Migration
  def change
    create_table :items,:id=>false do |t|
      t.uuid :id, :primary_key => true
      t.string :name
      t.text :description
      t.integer :level
      t.float :health
      t.float :atk
      t.float :def
      t.uuid :item_group_id

      t.timestamps
    end
  end
end
