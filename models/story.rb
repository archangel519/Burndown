require 'active_record'

class Story < ActiveRecord::Base
  
  has_many :tasks
  validates_uniqueness_of :id, :name
  
  def points=(value)
    value = value.to_i
    value = 1 unless value > 0
    @points = value
    super
  end
  
  #def self.tasks()
  #  if (@tasks.nil?)
  #    @tasks = where(story_id => @id)
  #  end
  #  
  #  @tasks
  #end
end