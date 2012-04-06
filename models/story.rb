require 'active_record'

class Story < ActiveRecord::Base
  attr_accessor :id
  attr_accessor :name
  attr_accessor :description
  attr_accessor :points
  
  validates_uniqueness_of :id
  
  def points=(value)
    @points = value.to_i
  end
end