class AddImageToItems < ActiveRecord::Migration
  def change
    add_column :items, :image_name, :string
  end
end
