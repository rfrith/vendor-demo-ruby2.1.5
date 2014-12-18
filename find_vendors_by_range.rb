require 'optparse'
require_relative 'vendor'
require_relative 'vendor_list'
puts "\n\n---------------------------------------------------------------------------------------------------"
puts "Please review & run the rspec tests in the /spec directory to test all library functionality."
puts "---------------------------------------------------------------------------------------------------"

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: $ruby ./runme.rb [options]"
  opts.on('-l n', '--lbound=n', OptionParser::DecimalInteger, 'Supply lower bound search criteria') { |v| options[:lbound] = v }
  opts.on('-u n', '--ubound=n', OptionParser::DecimalInteger, 'Supply upper bound search criteria') { |v| options[:ubound] = v }
end.parse!

if(options[:lbound].nil? || options[:ubound].nil?)
  puts "Please supply argument values for both lbound and ubound.  E.g., '$ruby ./find_vendors_by_range.rb -l 2500 -u 5000'"
  exit
end

puts "Reading vendor list from .yml file..."

@vendor_list = VendorList.new "vendor-list.yml"

puts "Found #{@vendor_list.vendors.size} vendors in database:\n\n #{@vendor_list.inspect}"

puts "..."

lbound = Integer(options[:lbound].to_i)
ubound = Integer(options[:ubound].to_i)

puts "Finding all vendors with lbound of #{lbound} and ubound of #{ubound}"

vendors = @vendor_list.find_vendors_by_range(lbound, ubound)

puts "Found #{vendors.size} vendors matching criteria: \n\n #{vendors.inspect}"