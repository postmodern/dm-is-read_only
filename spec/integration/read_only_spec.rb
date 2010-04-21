require 'spec_helper'

describe DataMapper::Is::ReadOnly do
  it "should define a VERSION constant" do
    DataMapper::Is::ReadOnly.const_defined?('VERSION').should == true
  end
end
