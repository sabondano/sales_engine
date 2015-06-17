require 'csv'

class Parser
  def self.parse(file_path)
    data = CSV.open(file_path, headers: true, header_converters: :symbol)
  end
end

# class MerchantParser
#
#   attr_reader :file,
#               :repository
#
#   def initialize(file_path, repository)
#     @file = file_path
#     @merchants = []
#     @repository = repository
#   end
#
#   def load_csv
#     CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
#       merchant_data = {:id => row[:id], :name => row[:name], :created_at => row[:created_at], :updated_at => row[:updated_at]}
#       @merchants << Merchant.new(merchant_data, repository)
#     end
#     @merchants
#   end
#
# end
