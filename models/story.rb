require 'active_record'

class Story < ActiveRecord::Base
  
  has_many :tasks
  validates_uniqueness_of :id, :name
  
  before_validation :non_zero_points
    
  def points=(value)
    value = value.to_i
    value = 1 unless value > 0
    write_attribute(:points, value)
  end
    
  private
    def non_zero_points
      self.points = 1 unless self.points
    end
end