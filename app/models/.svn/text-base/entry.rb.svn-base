class Entry < ActiveRecord::Base
  belongs_to :user, :counter_cache=>true
  has_many :comments
  validates_length_of :title, :maximum => 255
  validates_length_of :body, :maximum => 10000
  
  
  include CommonScopes
  named_scope :order,:order => 'entries.created_at desc'
  
  
  def after_save
    self.user.update_attribute(:last_activity, "Wrote a blog entry")
    self.user.update_attribute(:last_activity_at, Time.now)
  end
  #For Liquid template
  def to_liquid
    EntryDrop.new(self)
  end
  
end
