require 'digest/sha2'
require 'rss/2.0'
class User < ActiveRecord::Base
  attr_protected :hashed_password,:enabled
  attr_accessor :password
  
  has_and_belongs_to_many :roles
  has_many :articles
  has_many :entries
  has_many :comments
  has_many :photos, :extend=>TagCountsExtension
  
  #Many to many relationships using has_many through
  has_many :friendships
  has_many :friends, :through=> :friendships, :class_name=>'User'
  
  validates_presence_of :username,:email
  validates_presence_of :password, :if => :password_required?
  validates_presence_of :password_confirmation, :if => :password_required?
  
  validates_confirmation_of :password, :if => :password_required?
  validates_uniqueness_of :username, :case_sensitive => false
  validates_uniqueness_of :email, :case_sensitive => false
  
  validates_length_of :username, :within => 3..64
  validates_length_of :email, :within => 5..128
  validates_length_of :password, :within => 4..20, :if => :password_required?
  validates_length_of :profile, :maximum => 1000
  
  
  def before_save
    self.hashed_password = User.encrypt(password) if !self.password.blank?
    if self.has_attribute?('flickr_username') && !self.flickr_username.blank?
      self.flickr_id = self.get_flickr_id
    end
  end
  
  def password_required?
    self.hashed_password.blank? || !self.password.blank?
  end
  
  def self.encrypt(string)
    return Digest::SHA256.hexdigest(string)
  end
  def self.authenticate(username,password)
    find_by_username_and_hashed_password_and_enabled(username,User.encrypt(password),true)
  end
  def has_role?(rolename)
    self.roles.find_by_name(rolename) ? true :false
  end
  #Comment notifier method 
  def email_with_username
    "#{username} <#{email}>"
  end
  
  #For Flickr
  def get_flickr_id
    #build the flickr request with url, method fetching the name with the api key
    
    flickr_request = "http://api.flickr.com/services/rest/?"
    flickr_request << "method=flickr.people.findByUsername"
    flickr_request << "&username=#{self.flickr_username}"
    flickr_request << "&api_key=#{FLICKR_API_KEY}"
    
    
    #Perform the API call
    response=""
    open(flickr_request){|s| response = s.read}
    
    #Parsing the result
    
    xml_response = REXML::Document.new(response)
    xml_response.root.attributes["stat"].eql?("ok") ? xml_response.root.elements["user"].attributes["nsid"] : nil
  end
  
  #Fetching the Flickr Feed
  def flickr_feed
    flickr_request = "http://api.flickr.com/services/feeds/photos_public.gne?"
    flickr_request << "id=#{self.flickr_id}"
    flickr_request << "&format=rss_200_enc"
    
    rss_content = "" 
    open(flickr_request){|s| rss_content = s.read}
    
    return RSS::Parser.parse(rss_content,false)
  end
end
