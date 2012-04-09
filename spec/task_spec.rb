require 'spec_helper'
 
describe Task do

  before :all do
    ActiveRecord::Base.establish_connection(
      :adapter  => "mysql",
      :host     => "localhost",
      :username => "burndown",
      :password => "HappyBunnyFuzzySquirrel",
      :database => "burndown"
    )
    
    @task = Task.new  
  end
  
  describe "#new" do
      it "returns a new task object" do        
        @task.should be_an_instance_of Task
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