require 'active_record'

class Release < ActiveRecord::Base
  
  has_many :sprints
  validates_uniqueness_of :id, :title
  validates_presence_of :title, :status
  after_initialize :init
  
  private
    def init
      self.status ||= 1
    end
    
end