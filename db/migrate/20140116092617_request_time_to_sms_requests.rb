class RequestTimeToSmsRequests < ActiveRecord::Migration
  def change
   add_column :sms_requests, :request_time,:datetime
  end
end
