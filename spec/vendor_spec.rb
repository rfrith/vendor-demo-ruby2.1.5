require 'spec_helper'

describe Vendor do
  
  before :each do
    @vendor = Vendor.new "Name", 0, 10000
  end
  
  describe "#new" do
    
    it "throws an ArgumentError when given fewer than 3 parameters" do
      expect(lambda { Vendor.new "Test Vendor", 100 }).to raise_exception ArgumentError
    end
    
    describe "#name" do
      it "returns the correct name" do
        expect(@vendor.name).to eql "Name"
      end
      
      it "returns the correct price range lower bound" do
        expect(@vendor.price_range_lower_bound).to eql 0
      end
      
      it "returns the correct price range lower bound" do
        expect(@vendor.price_range_upper_bound).to eql 10000
      end
      
    end
    
  end
  
end