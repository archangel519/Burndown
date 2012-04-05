require 'rr'
require 'yaml'
require 'active_record'
require_relative '../models/story'
 
RSpec.configure do |config|
  config.mock_with :rr
end