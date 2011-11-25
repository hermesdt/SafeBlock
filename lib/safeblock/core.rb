class SafeBlock
  def self.do(options = {}, &block)
    
    proc = Proc.new do
      Timeout::timeout(timeout) do
        block.call
      end
    end

    if threaded
      Thread.new{ proc.call }
    else
      proc.call
    end

  end
end
