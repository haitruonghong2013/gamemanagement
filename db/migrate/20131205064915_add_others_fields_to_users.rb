class AddOthersFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address,:string
    add_column :users, :apn_token,:string
    add_column :users, :area_code,:string
    add_column :users, :avatar,:string
    add_column :users, :birthday,:datetime
    add_column :users, :city,:string
    add_column :users, :country,:string
    add_column :users, :cover,:string
    add_column :users, :created_date,:string
    #add_column :users, :email,:string
    add_column :users, :facebook_id,:string
    add_column :users, :gcm_token,:string
    add_column :users, :google_id,:string
    add_column :users, :language,:string
    add_column :users, :name,:string
    add_column :users, :note,:string
    add_column :users, :phone,:string
    add_column :users, :sex,:boolean
    add_column :users, :twitter_id,:string
    add_column :users, :type,:integer
    add_column :users, :avatar_thumb,:string
    #add_column :users, :ubox_authentication_token,:string
  end
end
