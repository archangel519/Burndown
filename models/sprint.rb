require 'active_record'

class Sprint < ActiveRecord::Base
  
  belongs_to :release
  has_many :stories
  validates_uniqueness_of :id, :scope => :release_id
  validates_uniqueness_of :title, :scope => :release_id
  validates_presence_of :release_id, :title, :status  
  after_initialize :init
  
  private
    def init
      self.status ||= 1
    end
    
end