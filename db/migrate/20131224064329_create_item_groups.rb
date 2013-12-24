class CreateItemGroups < ActiveRecord::Migration
  def change
    create_table :item_groups,:id=>false do |t|
      t.uuid :id, :primary_key => true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
