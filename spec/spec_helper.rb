require 'rr'
require 'yaml'
require 'active_record'
require_relative '../models/story'
require_relative '../models/task'
 
RSpec.configure do |config|
  config.mock_with :rr
end