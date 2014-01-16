class SmsRequest < ActiveRecord::Base
  include ActiveUUID::UUID
  belongs_to :character
  attr_accessible :access_key, :command, :mo_message, :msisdn, :request_id, :request_time, :short_code, :signature,:character_id
end
