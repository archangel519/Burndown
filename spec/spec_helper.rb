require 'rr'
require 'yaml'
require 'active_record'
require 'grape'
require 'rack/test'

require_relative '../models/story'
require_relative '../models/task'
 
RSpec.configure do |config|
  config.mock_with :rr
  config.include Rack::Test::Methods
end