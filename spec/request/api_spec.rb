require_relative '../spec_helper'

describe FireBurn do
  
  context "API" do
    describe "undefined route" do
      it "returns an error code of 404" do
        response = get "/v1/foobar"
        last_response.status.should == 404 
      end
    end
    describe "internal exception" do
      it "has a status code of 500" do
        response = get "/v1/error"
        last_response.status.should == 500 
      end
      it "returns a valid APIResponse object with an error set" do
        response = get "/v1/error"
        json_response = JSON.parse(response.body)
        json_response.should include("result", "error")
        json_response['error'].should_not be_nil
        json_response['result'].should be_nil
      end
    end
  end
  
  context "APIResponse" do
    describe "ResponseObject" do
      it "can be translated to a json object" do
        api_response = APIResponse.new()
        api_response.should respond_to(:to_json)
      end
    end
    describe "#new" do
      it "should set data passed to result" do
        api_response = APIResponse.new('THE DATA')
        api_response.result.should == 'THE DATA'
      end
    end
    describe "#result=" do
      it "should set data passed to result" do
        api_response = APIResponse.new
        api_response.result = 'THE DATA'
        api_response.result.should == 'THE DATA'
      end
      it "should set result to nil when setting error" do
        api_response = APIResponse.new('THE DATA')
        api_response.error = APIError.new('prefix', 1, 'THE ERROR')
        api_response.result.should be_nil
      end
      it "should modify error when trying to add result after error is set" do
        api_response = APIResponse.new()
        api_response.error = APIError.new('prefix', 1, 'FIRST ERROR')
        api_response.result = 'THE DATA'
        api_response.result.should be_nil
        api_response.error.message.should include('Error already set, unable to set result. Previous Error Message:')
        api_response.error.message.should include('FIRST ERROR')
      end
    end
  end
  
  context "Stories" do
    describe "GET /v1/stories" do
      it "returns an array of stories" do
        response = get "/v1/stories"
        last_response.status.should == 200
        json_response = JSON.parse(response.body)
        json_response['result'].should be_an Array
        json_response['error'].should be_nil
      end
    end
    describe "GET /v1/stories/1" do
      it "returns a story with id 1" do
        response = get "/v1/stories/1"
        last_response.status.should == 200
        result = JSON.parse(response.body)['result']
        result.should have(1).item
        result['story'].should be_a Hash
        result['story']['id'].should == 1
      end
    end
    describe "getting a story that does not exist" do
      it "returns 404 not found" do
        response = get "/v1/stories/abc"
        last_response.status.should == 404
        response.body.should == 'Story Not Found'
      end
    end
    describe "updating a story that does not exist" do
      it "returns 404 not found" do
        response = put "/v1/stories/abc"
        last_response.status.should == 404
        response.body.should == 'Story Not Found'
      end
    end
    describe "updating a story" do
      it "updates the story in the db and returns the updated story" do
        mock(Story).save { true }
        current_time = Time.now.strftime("%H:%M:%S")
        
        response = put "/v1/stories/1", {'title' => "Title #{current_time}"}
        last_response.status.should == 200
        result = JSON.parse(response.body)['result']
        error = JSON.parse(response.body)['error']
        error.should be_nil
        result['story']['title'].should == "Title #{current_time}"
      end
    end
    describe "deleting a story that does not exist" do
      it "returns 404 not found" do
        response = put "/v1/stories/abc"
        last_response.status.should == 404
        response.body.should == 'Story Not Found'
      end
    end
  end
  
  context "Tasks" do
    describe "GET /v1/tasks?story_id=1" do
      it "returns an array of tasks" do
        response = get "/v1/tasks?story_id=1"
        last_response.status.should == 200
        json_response = JSON.parse(response.body)
        json_response['result'].should be_an Array
        json_response['error'].should be_nil
      end
    end
    describe "GET /v1/tasks" do
      it "returns an error stating story id is not set" do
        response = get "/v1/tasks"
        last_response.status.should == 200
        json_response = JSON.parse(response.body)
        json_response['result'].should be_nil
        json_response['error']['message'].should include('Story ID not specified')
      end
    end
  end

end