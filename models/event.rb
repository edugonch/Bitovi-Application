require File.dirname(__FILE__) + '/base'

module Bitovi
  class Event < Base
    attr_accessor :name

    def initialize(name)
      @name = name
    end
  end
end