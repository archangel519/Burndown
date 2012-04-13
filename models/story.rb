require 'active_record'

class Story < ActiveRecord::Base
  
  belongs_to :sprint
  has_many :tasks
  validates_uniqueness_of :id, :scope => :sprint_id
  validates_uniqueness_of :title, :scope => :sprint_id
  validates_presence_of :sprint_id, :title, :points
  after_initialize :init
  
  def points=(value)
    value = value.to_i
    value = 1 unless value > 0
    write_attribute(:points, value)
  end
      
  private
    def init
      self.points ||= 1
    end
end