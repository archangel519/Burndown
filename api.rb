require File.join(File.dirname(__FILE__), "system/api_response.rb")
require File.join(File.dirname(__FILE__), "system/api_error.rb")

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
      
      
      response = APIResponse.new()
      response.result = {:success => true}
      response.toJSON
    end
  end
end