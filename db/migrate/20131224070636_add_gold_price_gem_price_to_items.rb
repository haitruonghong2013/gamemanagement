class AddGoldPriceGemPriceToItems < ActiveRecord::Migration
  def change
    add_column :items,:gold, :float
    add_column :items,:gem, :float
  end
end
