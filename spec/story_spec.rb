require 'spec_helper'
 
describe Story do

  before :all do
    ActiveRecord::Base.establish_connection(
      :adapter  => "mysql",
      :host     => "localhost",
      :username => "burndown",
      :password => "HappyBunnyFuzzySquirrel",
      :database => "burndown"
    )
    
    @story = Story.new  
  end
  
  describe "#new" do
      it "returns a new story object" do        
        @story.should be_an_instance_of Story
      end
  end
  
  describe "#points=" do
      context "with a floating point number" do
          it "sets #points to an integer" do
            @story.points = 5.1234
            @story.points.should eql 5
          end
      end
      
      context 'with nil' do
        it "sets #points to 1" do
          @story.points = nil
          @story.points.should eql 1
        end
      end
  end
  
  describe '#save' do
    it "calls the right setter method for points" do
      mock(@story).save { true }
      @story.points = nil
      @story.save
      @story.points.should eql 1
    end
  end
  
  describe '#create' do
    it "calls the right setter method for points" do
      mock(@story).save { true }
      @story = Story.create(:name => 'Story1')
      @story.points.should eql 1
    end
  end
  
  describe "#tasks" do
    it "gets a list of the tasks for this story"
  end
  
end  