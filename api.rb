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
  
  resource :stories do
    post {
      name = params[:name]
      points = params[:points].to_i
      description = params[:description]
      
      story = Story.new
      story.name = params[:name]  
      story.points = params[:points]
      story.description = params[:description]
      story.save
      
      response = APIResponse.new(story)
      response.toJSON
    }
    
    get {
      stories = Story.all
      response = APIResponse.new(stories)
      response.toJSON
    }
    
    put ":id" do
      name = params[:name]
      points = params[:points].to_i
      description = params[:description]
              
      story = Story.find(params[:id])
      story.name = name
      story.points = points
      story.description = description
      
      story.save  
      response = APIResponse.new(story)
      response.toJSON
    end
    
    get ":id" do
      response = APIResponse.new(Story.find(params[:id]))
      response.toJSON
    end
    
    delete ":id" do
      response = APIResponse.new(Story.delete(params[:id]))
      response.toJSON
    end
  end
end