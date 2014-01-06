class Version < ActiveRecord::Base
  attr_accessible :description, :name, :version, :download_url
end
