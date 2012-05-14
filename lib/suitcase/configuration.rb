module Suitcase
  def self.configure(&block)
    block.call(@configuration ||= Configuration.new)
  end

  def self.configuration
    @configuration.options || {}
  end

  class Configuration
    # Internal: The Hash of options that are currently configured.
    attr_reader :options

    def initialize
      @options = {}
    end

    def method_missing(method, *args, &blk)
      if method.to_s =~ /^(.+)=$/
        @options[$1.to_sym] = args.first
      else
        super(method, args, blk)
      end
    end
  end
end
