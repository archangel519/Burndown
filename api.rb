require File.join(File.dirname(__FILE__), "system/api_response.rb")
require File.join(File.dirname(__FILE__), "system/api_error.rb")
require File.join(File.dirname(__FILE__), "models/story.rb")
require File.join(File.dirname(__FILE__), "models/task.rb")

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
    Rack::Response.new([ response.to_json ], 500, { "Content-type" => "application/json" }).finish
  end
  
  resource :error do
    get {
      raise 'API Error' #for testing
    }
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
      response
    }
    
    get {
      stories = Story.limit(100)
      response = APIResponse.new(stories)
      response
    }
    
    put ":id" do
      name = params[:name]
      points = params[:points].to_i
      description = params[:description]
      
      story = Story.find_by_id(params[:id])
      if story 
        story.name = name
        story.points = points
        story.description = description
        
        story.save  
        response = APIResponse.new(story)
        response
      else
        error!('Story Not Found', 404)
      end
    end
    
    get ":id" do
      story = Story.find_by_id(params[:id])
      if story
        response = APIResponse.new(story)
        response
      else
        error!('Story Not Found', 404)
      end
    end
    
    delete ":id" do
      story = Story.find_by_id(params[:id])
      if story
        response = APIResponse.new(story)
        response
      else
        error!('Story Not Found', 404)
      end
    end
  end
  
  resource :tasks do
    post {      
      task = Task.new
      task.story_id = params[:story_id]
      task.title = params[:title]
      task.description = params[:description]
      task.hours = params[:hours]
      task.owner = params[:owner]
      
      if task.save
        response = APIResponse.new(story)
      else
        response = APIResponse.new
        response.error = APIError.new('NewTask', 1, 'Unable to create new task.')
      end
      
      response
    }
    
    get {
      id = params[:story_id].to_i
      if id != 0
        tasks = Task.find_all_by_story_id(id)
        response = APIResponse.new(tasks)
      else
        response = APIResponse.new
        response.error = APIError.new('GetTasks', 1, 'Story ID not specified.')
      end

      response
    }
  end
end