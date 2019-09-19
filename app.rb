require 'slack-notifier'
require 'securerandom'

WEBHOOK_URL = 'YOUR_WEBHOOK_URL'

def foobar(event:, context:)
  notifier = Slack::Notifier.new(WEBHOOK_URL)
  notifier.ping SecureRandom.hex(16)
end