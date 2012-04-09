require 'active_record'

class Task < ActiveRecord::Base

  attr_reader :tasks
  
  belongs_to :story
  validates_uniqueness_of :id, :scope => :story_id
  validates_uniqueness_of :title, :scope => :story_id
  validates_presence_of :story_id
  
  def hours=(value)
    value = value.to_f
    if value <= 0
      value = 0.25 #has to be at least .25 hours
    end
   
    #round up to nearest .25
    rem = value % 0.25
    value = (value - rem) + 0.25 unless rem == 0
    @hours = value.round(2).to_f
    super
  end

end