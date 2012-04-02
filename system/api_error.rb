class APIError < StandardError
  attr_reader :code, :type
  
  def initialize(prefix, code, message, type = nil, data = nil)
    @prefix = prefix
    @code = code
    @message = message
    @type = type
    @data = data
  end

  def to_s
    "[#{@prefix} #{@code}] - #{@message}"
  end

  def forJSON
    tmpObject = {
      prefix: @prefix,
      code: @code,
      message: @message,
      type: @type,
      data: @data
    }

    tmpObject
  end

end 