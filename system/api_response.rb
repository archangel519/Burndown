#borrowed from Radial https://github.com/RetroMocha/radial
require 'json'
require File.join(File.dirname(__FILE__), "api_error.rb")

class APIResponse
  def initialize()
    @result = nil
    @error = nil
  end
  
  def result=(input)
    if !@error.nil?
      prefix = "Response setResult"
      message = "Error already set, unable to set result."
      @error = APIError.new(prefix, 1, message);
      @result = nil
    else
      @result = input
    end
  end

  def result
    if !@error.nil? and !@result.nil?
      prefix = "Response getResult"
      message = "Error already set, unable to get result."
      @error = APIError.new(prefix, 1, message)
      @result = nil
    end

    @result
  end

  def error=(input)
    if !@result.nil?
      prefix = "Response setError"
      message = "Response already set before setting error!"
      @error = APIError.new(prefix, 1, message)
      @result = nil
    else
      @error = input
    end
  end

  def error
    if !@error.nil? and !@result.nil?
      # handle error
    else
      return @error
    end
  end

  def toJSON
    jsonObject = Hash.new
    jsonObject[:result] = @result
    jsonObject[:error] = @error

    if !@error.nil?
      jsonObject[:error] = @error.forJSON()
    end

    jsonObject.to_json
  end
end