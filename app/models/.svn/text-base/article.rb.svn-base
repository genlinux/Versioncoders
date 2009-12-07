class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  
  validates_presence_of :title,:synopsis,:body
  validates_length_of :title,:maximum=>25
  validates_length_of :synopsis,:maximum=>1000
  validates_length_of :body,:maximum=>20000
  
  before_save :update_published_at
  
  include CommonScopes
  
  #Articles latest order
  named_scope :order,:order => 'articles.published_at desc'
  named_scope :published,:conditions => {:published => true}
  named_scope :category,lambda {|category_id| { :conditions => ['category_id = ?', category_id] }}
  named_scope :limit, lambda {|limit| {:limit => limit}}
    
    #Automatically updating the published_at field
    def update_published_at
      self.published_at=Time.now if published==true
    end
    
    
end