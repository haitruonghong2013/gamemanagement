class CreateSmsRequests < ActiveRecord::Migration
  def change
    create_table :sms_requests do |t|
      t.string :access_key
      t.string :command
      t.string :mo_message
      t.string :msisdn
      t.string :request_id
      t.string :short_code
      t.text :signature
      t.uuid :character_id
      t.timestamps
    end
  end
end
