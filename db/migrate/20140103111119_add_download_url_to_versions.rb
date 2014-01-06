class AddDownloadUrlToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :download_url,:string
  end
end
