require_relative '../spec_helper'

describe Grape::API do
  subject { Class.new(Grape::API) }

  def app; subject end
    
  describe "GET /v1/stories" do
    it "returns an array of stories" do
      get "/v1/stories"
      last_response.status.should == 200
      JSON.parse(response.body).should be_a_kind_of(Hash)
    end
  end
  describe "GET /v1/stories/:id" do
    it "returns a story with id 1" do
      get "/v1/stories/1"
      last_response.status.should == 200
      story = JSON.parse(response.body)
      story.id.should eql 1
    end
  end
end