class Version < ActiveRecord::Base
  mount_uploader :jar_file, GameFileUploader
  mount_uploader :apk_file, GameFileUploader
  attr_accessible :description, :name, :version, :download_url,
                  :jar_file, :apk_file, :apk_file_cache, :jar_file_cache
end
