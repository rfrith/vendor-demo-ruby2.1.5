require 'spec_helper'

describe "VendorList Object" do
  
  before :all do
    vendor_list = [
      Vendor.new("Company A", 1000, 3000),
      Vendor.new("Company B", 6000, 10000),
      Vendor.new("Company C", 500, 2500)
      ]
      
      File.open "vendor-list.yml", "w" do |f|
        f.write YAML::dump vendor_list
      end
  end
  
  before :each do
    @vendors = VendorList.new "vendor-list.yml"
  end
  
  describe "#new" do
  

        
    it "returns all vendors in a given price range lower bound" do
      vendors =  @vendors.find_vendors_by_lower_bound(0)
      expect(vendors.length).to be 0
      
      vendors =  @vendors.find_vendors_by_lower_bound(500)
      expect(vendors.length).to be 1
      expect(vendors.find { |v| v.name == "Company A" }).to be_nil
      expect(vendors.find { |v| v.name == "Company B" }).to be_nil
      expect(vendors.find { |v| v.name == "Company C" }).to_not be_nil
      
      vendors =  @vendors.find_vendors_by_lower_bound(2500)
      expect(vendors.length).to be 2
      expect(vendors.find { |v| v.name == "Company A" }).to_not be_nil
      expect(vendors.find { |v| v.name == "Company B" }).to be_nil
      expect(vendors.find { |v| v.name == "Company C" }).to_not be_nil
      
      vendors =  @vendors.find_vendors_by_lower_bound(6000)
      expect(vendors.length).to be 3
      expect(vendors.find { |v| v.name == "Company A" }).to_not be_nil
      expect(vendors.find { |v| v.name == "Company B" }).to_not be_nil
      expect(vendors.find { |v| v.name == "Company C" }).to_not be_nil
    end
    
    it "returns all vendors in a given price range upper bound" do      
      vendors =  @vendors.find_vendors_by_upper_bound(0)
      expect(vendors.length).to be 0
      
      vendors =  @vendors.find_vendors_by_upper_bound(2500)
      expect(vendors.length).to be 1
      expect(vendors.find { |v| v.name == "Company A" }).to be_nil
      expect(vendors.find { |v| v.name == "Company B" }).to be_nil
      expect(vendors.find { |v| v.name == "Company C" }).to_not be_nil
      
      vendors =  @vendors.find_vendors_by_upper_bound(5000)
      expect(vendors.length).to be 2
      expect(vendors.find { |v| v.name == "Company A" }).to_not be_nil
      expect(vendors.find { |v| v.name == "Company B" }).to be_nil
      expect(vendors.find { |v| v.name == "Company C" }).to_not be_nil
      
      vendors =  @vendors.find_vendors_by_upper_bound(10000)
      expect(vendors.length).to be 3
      expect(vendors.find { |v| v.name == "Company A" }).to_not be_nil
      expect(vendors.find { |v| v.name == "Company B" }).to_not be_nil
      expect(vendors.find { |v| v.name == "Company C" }).to_not be_nil
    end
    
    it "returns all vendors whose price range lower and upper bounds are within given range" do
      vendors =  @vendors.find_vendors_by_range(0, nil)
      expect(vendors.length).to be 0
      
      vendors =  @vendors.find_vendors_by_range(0, 0)
      expect(vendors.length).to be 0
      
      vendors =  @vendors.find_vendors_by_range(nil, 0)
      expect(vendors.length).to be 0
      
      vendors =  @vendors.find_vendors_by_range(nil, nil)
      expect(vendors.length).to be 3
      
      vendors =  @vendors.find_vendors_by_range(500, 2500)
      expect(vendors.length).to be 1
      expect(vendors.find { |v| v.name == "Company A" }).to be_nil
      expect(vendors.find { |v| v.name == "Company B" }).to be_nil
      expect(vendors.find { |v| v.name == "Company C" }).to_not be_nil
      
      vendors =  @vendors.find_vendors_by_range(2500, 5000)
      expect(vendors.length).to be 2
      expect(vendors.find { |v| v.name == "Company A" }).to_not be_nil
      expect(vendors.find { |v| v.name == "Company B" }).to be_nil
      expect(vendors.find { |v| v.name == "Company C" }).to_not be_nil
      
      vendors =  @vendors.find_vendors_by_range(6000, 10000)
      expect(vendors.length).to be 3
      expect(vendors.find { |v| v.name == "Company A" }).to_not be_nil
      expect(vendors.find { |v| v.name == "Company B" }).to_not be_nil
      expect(vendors.find { |v| v.name == "Company C" }).to_not be_nil
    end
  
  end
  
end