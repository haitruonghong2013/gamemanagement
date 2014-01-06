class AddJarApkFileToVerions < ActiveRecord::Migration
  def change
    add_column :versions, :jar_file, :string
    add_column :versions, :apk_file, :string
  end
end
