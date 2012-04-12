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
        api_response.error.message.should == '[Response setResult 1] - Error already set, unable to set result. Previous Error Message: [prefix 1] - FIRST ERROR'
      end
    end
  end
  
  context "Stories" do
    describe "GET /v1/stories" do
      it "returns an array of stories" do
        response = get "/v1/stories"
        last_response.status.should == 200
        json_response = JSON.parse(response.body)
        result = json_response['result']
        result.should be_an Array
        result.should have_at_least(1).items
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
    describe "deleting a story that does not exist" do
      it "returns 404 not found" do
        response = put "/v1/stories/abc"
        last_response.status.should == 404
        response.body.should == 'Story Not Found'
      end
    end
  end

end