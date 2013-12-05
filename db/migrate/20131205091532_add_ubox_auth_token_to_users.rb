class AddUboxAuthTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ubox_authentication_token,:string
  end
end
