require "rspec"
require '../safeblock/safeblock'
require '../safeblock/safeblock_module'

class A
  include SafeblockModule

  def raise_exception
    1/0
  end
end

describe "SafeBlock behaviour" do

  it "anonymous object should extend safe_block_module" do
    A.ancestors.include?(SafeblockModule).should == true
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
end