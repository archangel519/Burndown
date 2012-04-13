require 'rr'
require 'yaml'
require 'active_record'
require 'grape'
require 'rack/test'

require_relative '../models/release'
require_relative '../models/sprint'
require_relative '../models/story'
require_relative '../models/task'
require_relative '../api'
 
RSpec.configure do |config|
  config.mock_with :rr
  config.include Rack::Test::Methods
end

def app; FireBurn; end