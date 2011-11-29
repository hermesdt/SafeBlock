require 'timeout'

class SafeBlock
  def self.start(options = {}, &block)

    setup{} if @configuration.nil?

    options = @configuration.merge(options)

    proc = Proc.new do |options|
      Timeout::timeout(options[:timeout]) do
        begin
          block.call
        rescue Exception => e
          raise e if options[:ignore_exception]
          options[:rescue_block].call(e) if options[:rescue_block].is_a? Proc
        end
      end
    end

    if options[:threaded]
      Thread.new{ proc.call(options) }
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

    VALUES = :timeout, :threaded, :rescue_block, :ignore_exception
    attr_accessor *VALUES

    def initialize
      @timeout = 0
      @threaded = false
      @ignore_exception = false
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