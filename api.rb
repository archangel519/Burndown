$BASE_CODE_PATH = File.dirname(__FILE__)
$BASE_CONFIG_PATH = File.join($BASE_CODE_PATH, '/config')

require File.join($BASE_CODE_PATH, "system/api_response.rb")
require File.join($BASE_CODE_PATH, "system/api_error.rb")
require File.join($BASE_CODE_PATH, "models/story.rb")
require File.join($BASE_CODE_PATH, "models/task.rb")

db_config_path = File.join($BASE_CONFIG_PATH, 'db_config.yml')
db_config = YAML::load(File.open(db_config_path))
ActiveRecord::Base.establish_connection(db_config)

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
      title = params[:title]
      points = params[:points].to_i
      description = params[:description]
      
      story = Story.new
      story.title = params[:title]  
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
      story = Story.find_by_id(params[:id])
      if story 
        story.title = params[:title] unless params[:title].nil?
        story.points = params[:points].to_i unless params[:points].nil?
        story.description = params[:description] unless params[:description].nil?
        
        if story.save  
          response = APIResponse.new(story)
        else 
          response = APIResponse.new
          response.error = APIError.new('UpdateStory', 1, 'Unable to update story.')
        end
        
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
        begin 
          response = APIResponse.new(story.destroy)
        rescue
          response = APIResponse.new
          response.error = APIError.new('DeleteStory', 1, 'Unable to delete story.')
        end
        
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
    
    put ":id" do
      task = Task.find_by_id_and_story_id(params[:id], params[:story_id])
      if task 
        task.title = params[:title] unless params[:title].nil?
        task.hours = params[:hours] unless params[:hours].nil?
        task.description =  params[:description] unless params[:description].nil?
        task.owner =  params[:owner] unless params[:owner].nil?
        task.story_id =  params[:new_story_id] unless params[:new_story_id].nil?
          
        if task.save  
          response = APIResponse.new(task)
        else 
          response = APIResponse.new
          response.error = APIError.new('UpdateTask', 1, 'Unable to update task.')
        end
        
        response
      else
        error!('Story Not Found', 404)
      end
    end
    
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