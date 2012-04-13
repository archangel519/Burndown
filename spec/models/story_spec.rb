require_relative '../spec_helper'
 
describe Story do

  before :all do
    ActiveRecord::Base.establish_connection(
      :adapter  => "mysql",
      :host     => "localhost",
      :username => "burndown",
      :password => "HappyBunnyFuzzySquirrel",
      :database => "burndown"
    )
  end
  
  before :each do
    @story = Story.new
  end
  
  it "has many tasks" do
    @story.should respond_to(:tasks)
  end
  
  describe "#new" do
    context "with no parameters" do
      it "returns a new story object" do         
        @story.should be_an_instance_of Story
      end
    end
    context "with minimum parameters" do
      it "should be valid" do
        @story = Story.new :sprint_id => 1, :title => 'MyTitle'
        @story.should be_valid
      end
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
  
end  