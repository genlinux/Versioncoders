class Post < ActiveRecord::Base
  belongs_to :topic,:counter_cache=>true
  belongs_to :user, :counter_cache=>true
  
  include CommonScopes
  
  validates_presence_of :body
  validates_length_of :body, :maximum => 1000
  
  named_scope :topic_id, lambda{|topic| {:conditions => [ "topic_id = ? ", topic ]}}
  

  
  def after_save
    self.user.update_attribute(:last_activity, "Posted in the forum")
    self.user.update_attribute(:last_activity_at, Time.now)
  end
  
end
