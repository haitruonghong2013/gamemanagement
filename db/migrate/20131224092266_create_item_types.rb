class CreateItemTypes < ActiveRecord::Migration
  def change
    create_table :item_types,:id=>false do |t|
      t.uuid :id, :primary_key => true
      t.string :name
      t.text :description
      t.uuid :item_group_id
      t.timestamps
    end
  end
end
