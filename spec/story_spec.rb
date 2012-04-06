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
        it "sets #points to 0" do
          @story.points = nil
          @story.points.should eql 0
        end
      end
  end
  
end  