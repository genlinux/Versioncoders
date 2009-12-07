module Callbacks
  # When a class is including this module
  def self.included(base)
    # include: will mix the methods in the caller as instance ones.
    # include: is a private method that's why we are using 'send'
    base.send :include, InstanceMethods
    # extend: will mix the methods in the caller as class ones.
    # extend: is a private method that's why we are using 'send'
    base.send :extend, SingletonMethods
    base.class_eval do
    end
  end
  
  # Put all the the methods that should be mixed as instance ones here.
  module InstanceMethods
    def hello ; puts "hello" ; end
  end
  
  # Put all the the methods that should be mixed as class ones here.
  module SingletonMethods
    def bye;
      puts "bye";
    end
  end
  
  
  
end