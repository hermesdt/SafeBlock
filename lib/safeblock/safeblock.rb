require 'timeout'

class SafeBlock
  def self.start(options = {}, &block)

    options = @configuration.merge(options)

    proc = Proc.new do |options|
      Timeout::timeout(options[:timeout]) do
        begin
          block.call
        rescue Exception => e
          options[:rescue_block].call(e) if options[:rescue_block].is_a? Proc
        end
      end
    end

    if options[:threaded]
      Thread.new{ proc.call }
    else
      proc.call(options)
    end

  end

  def self.configuration
    @configuration
  end

  def self.setup(&block)
    @configuration = SafeBlock::Configuration.new

    block.call(@configuration)

    @configuration = @configuration.to_hash
  end

  class Configuration

    VALUES = :timeout, :threaded, :rescue_block
    attr_accessor *VALUES

    def initialize
      @timeout = 0
      @threaded = false
    end

    def to_hash
      hash = {}
      VALUES.each do |value|
        hash[value] = self.send(value)
      end
      hash
    end

  end
end