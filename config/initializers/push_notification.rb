#APNS.host = 'gateway.push.apple.com'
# gateway.sandbox.push.apple.com is default
#APNS.host = 'gateway.sandbox.push.apple.com'
APNS.host = 'gateway.push.apple.com'

#APNS.pem  = File.join(RAILS_ROOT, 'config', 'apple_push_notification_development.pem')
#APNS.pem = Rails.root.join('config/aps_development.pem')
APNS.pem = Rails.root.join('config/aps_production.pem')

#'../../../../appId.pem'
# this is the file you just created

APNS.port = 2195
# this is also the default. Shouldn't ever have to set this, but just in case Apple goes crazy, you can.