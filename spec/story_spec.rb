require 'spec_helper'
 
describe Story do

  describe "#new" do
      it "returns a new story object" do
        
        ActiveRecord::Base.establish_connection(
          :adapter  => "mysql",
          :host     => "localhost",
          :username => "burndown",
          :password => "HappyBunnyFuzzySquirrel",
          :database => "burndown"
        )
        
        story = Story.new  
        story.should be_an_instance_of Story
      end
  end
  
end  