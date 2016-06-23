require File.dirname(__FILE__) + '/../config'
require File.dirname(__FILE__) + '/../util/data_accessable'

require 'rubygems'
require 'active_support/core_ext/string'

#The base class is here to encapsulate common interfaces through out the models
#Also encapsulate the access to redis implementing the DataAccess Interface/Module

module Bitovi
  class Base
    include DataAccessable
    
    def initialize

    end

    def save
      self.attributes.each do |att|
        push_to_list(self.class.name.pluralize, self.send(att))
        log_info("Pushing into #{self.class.name.pluralize} value: #{self.send(att)}")
      end
    rescue Exception => ex
      log_error(ex.message)
    end

    def self.attr_accessor(*vars)
      @attributes ||= []
      @attributes.concat vars
      super(*vars)
    end

    def self.attributes
      @attributes
    end

    def attributes
      self.class.attributes
    end

  end
end