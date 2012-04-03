require File.join(File.dirname(__FILE__), "system/api_response.rb")
require File.join(File.dirname(__FILE__), "system/api_error.rb")
require File.join(File.dirname(__FILE__), "models/story.rb")

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql",
  :host     => "localhost",
  :username => "burndown",
  :password => "HappyBunnyFuzzySquirrel",
  :database => "burndown"
)

class FireBurn < Grape::API
  version 'v1'
  format :json
  default_format :json
    
  rescue_from :all do |e|
    response = APIResponse.new()
    response.error = APIError.new('System Exception', 500, e.message)
    Rack::Response.new([ response.toJSON ], 200, { "Content-type" => "application/json" }).finish
  end
  
  resource :story do
    get :create do
      
      story = Story.create(:name => 'Story1', :points => 2, :description => 'test description')
      response = APIResponse.new()
      response.result = {:data => story}
      response.toJSON
    end
  end
end