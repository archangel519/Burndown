require_relative '../spec_helper'
 
describe Release do

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
    @release = Release.new
  end
  
  it "has many sprints" do
    @release.should respond_to(:sprints)
  end
  
  describe "#new" do
    context "with no parameters" do
      it "returns a new release object" do
        @release.should be_an_instance_of Release
      end
    end
    context "with minimum parameters" do
      it "should be valid" do
        @release = Release.new :title => 'MyTitle'
        @release.should be_valid
      end
    end
  end
  
end  