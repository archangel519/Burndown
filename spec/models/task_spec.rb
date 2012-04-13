require_relative '../spec_helper'
 
describe Task do

  before :all do
    db_config_path = File.join($BASE_CONFIG_PATH, 'db_config.yml')
    db_config = YAML::load(File.open(db_config_path))
    ActiveRecord::Base.establish_connection(db_config)
  end
  
  before :each do
    @task = Task.new  
  end
  
  describe "#new" do
    context "with no parameters" do
      it "returns a new task object" do        
        @task.should be_an_instance_of Task
      end
      it "should initialize with 0.25 hours" do        
        @task.hours.should == 0.25
      end
    end
    context "with minimum parameters" do
      it "should be valid" do
        @task = Task.new :story_id => 1, :title => 'MyTitle'
        @task.should be_valid
      end
    end
  end
  
  describe "#hours=" do
    context "with a long precision floating point number" do
        it "rounds #hours UP to nearest .25 and sets #hours" do
          @task.hours = 5.24856
          @task.hours.should eql 5.25
        end
        it "rounds #hours UP to nearest .25 and sets #hours" do
          @task.hours = 5.50856
          @task.hours.should eql 5.75
        end
    end
    
    context 'with nil' do
      it "sets #points to 0.25" do
        @task.hours = nil
        @task.hours.should eql 0.25
      end
    end
  end
  
end  