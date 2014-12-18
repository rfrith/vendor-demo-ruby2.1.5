require "yaml"

class VendorList

  attr_reader :vendors
  
  def initialize vendor_list_file = false
    @vendor_list_file = vendor_list_file
    @vendors = @vendor_list_file ? YAML::load(File.read(@vendor_list_file)) : []
  end
  
  def find_vendors_by_lower_bound lbound
    find_vendors(lbound, nil)
  end
  
  def find_vendors_by_upper_bound ubound
    find_vendors(nil, ubound)
  end
  
  def find_vendors_by_range(lbound, ubound)
    find_vendors(lbound, ubound)
  end
  
  private
  
  def find_vendors(lbound=nil, ubound=nil)
    
    #return all vendors
    if(!lbound && !ubound)
      conditions = []
    
    #return all vendors in given range
    elsif(lbound && ubound)
      conditions = [
         proc { |i| i.price_range_lower_bound <= lbound },
         proc { |i| i.price_range_upper_bound <= ubound } 
       ]
    
    #return all vendors in range of supplied lbound
    elsif(!ubound)
      conditions = [
         proc { |i| i.price_range_lower_bound <= lbound }
       ]      
    
    #return all vendors in range of supplied ubound
    elsif(!lbound)
      conditions = [
         proc { |i| i.price_range_upper_bound <= ubound }
       ]  
    end    
    
    @vendors.select do |vendor|
      conditions.all? { |c| c[vendor] }
    end
  end
  
end