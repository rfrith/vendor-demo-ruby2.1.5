class Vendor
  attr_accessor :name, :price_range_lower_bound, :price_range_upper_bound
  def initialize name, price_range_lower_bound, price_range_upper_bound
    @name = name
    @price_range_lower_bound = price_range_lower_bound
    @price_range_upper_bound = price_range_upper_bound
  end
end