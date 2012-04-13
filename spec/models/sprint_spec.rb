require_relative '../spec_helper'
 
describe Sprint do

  before :all do
    db_config_path = File.join($BASE_CONFIG_PATH, 'db_config.yml')
    db_config = YAML::load(File.open(db_config_path))
    ActiveRecord::Base.establish_connection(db_config)
  end
  
  before :each do
    @sprint = Sprint.new
  end
  
  it "has many stories" do
    @sprint.should respond_to(:stories)
  end
  
  describe "#new" do
    context "with no parameters" do
      it "returns a new sprint object" do         
        @sprint.should be_an_instance_of Sprint
      end
    end
    context "with minimum parameters" do
      it "should be valid" do
        @sprint = Sprint.new :release_id => 1, :title => 'MyTitle'
        @sprint.should be_valid
      end
    end
  end
  
end  