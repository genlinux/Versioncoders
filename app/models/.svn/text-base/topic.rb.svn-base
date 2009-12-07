class Topic < ActiveRecord::Base
  belongs_to :forum, :counter_cache=>true
  belongs_to :user
  has_many :posts, :dependent=>:delete_all
  
  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  
  include CommonScopes
  
  named_scope :forum_id, lambda{|forum| {:conditions => [ "forum_id = ? ", forum ]}}
  named_scope :order,:order => 'topics.updated_at desc'
end
