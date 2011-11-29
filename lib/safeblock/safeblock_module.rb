
module SafeblockModule

  #add macro to use inside classes
  #the macro must accept a method name and optionally a options hash
  #
  #example of use:
  #
  #    rescue_method :my_method, {:threaded => true}
  #    rescue_method :my_method, {:timeout => 3}
  #    rescue_method :my_method

  def rescue_method(method_name, options = {})
    alias_method :"old_safeblock_#{method_name}", :"#{method_name}"

    define_method :"#{method_name}" do |*args,&block|
    SafeBlock.start(options) do
      instance_eval do
        send :"old_safeblock_#{method_name}", args, block
      end

    end
    end
  end

end