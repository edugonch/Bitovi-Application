require 'logger'

module Bitovi

  module Loggeable
    @@logger = Logger.new(STDOUT)

    def log_error msg
      @@logger.error msg
    end

    def log_info msg
      @@logger.info msg
    end
  end

  #Extend all classes within the module to include Logger
  extender = lambda do |k|
    k.constants.map {|c| k.const_get c }.
    select {|c| c.is_a? Class or c.is_a? Module }.
    each do |c|
      next if c == Loggeable
      c.send(:include, Loggeable)
      extender[c]
    end
  end

  extender[self]
end