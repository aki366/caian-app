# see: https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#configure-your-test-suite
require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
