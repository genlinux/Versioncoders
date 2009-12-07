module CommonScopes
  
  def self.included(base)
    base.class_eval do
      named_scope :limit, lambda {|limit| {:limit => limit}}
      named_scope :include_user,:include=>:user
    end
  end
end
#ActiveRecord::Base.extend(CommonScopes)
#Refer http://blog.jayfields.com/2006/05/ruby-extend-and-include.html