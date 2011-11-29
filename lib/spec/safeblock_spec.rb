require "rspec"
require '../safeblock/safeblock'
require '../safeblock/safeblock_module'

class A
  extend SafeblockModule

  def raise_exception
    1/0
  end
  rescue_method :raise_exception
end

describe "SafeBlock behaviour" do

  it "anonymous object should extend safe_block_module" do
    A.is_a?(SafeblockModule).should be_true
  end

  it "anonymous object should have rescue_method macro" do
    A.should respond_to(:rescue_method)
  end

  it "anonymous object should respond_to a_method and old_safeblock_a_method" do
    a = A.new
    a.should respond_to(:raise_exception)
    a.should respond_to(:old_safeblock_raise_exception)

  end

  it "anonymous object should not raise Exception" do
    a = A.new
    lambda{a.raise_exception}.should_not raise_exception(ZeroDivisionError)
  end

  #it "anonymous object run a method threaded" do
  #  class A
  #    def threaded_method
  #      sleep 10
  #      puts "from threade method! should never appear"
  #      sleep 10
  #    end
  #    rescue_method :threaded_method, :threaded => true
  #  end
  #
  #  a = A.new
  #  a.threaded_method
  #end

    it "anonymous object should raise exception" do
    class A
      def throw_exception
        1/0
      end
      rescue_method :throw_exception, :ignore_exception => true
    end

    a = A.new
    lambda{a.throw_exception}.should raise_exception(ZeroDivisionError)
  end
end