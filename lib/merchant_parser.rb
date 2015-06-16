require 'CSV'
require_relative 'merchant'

class MerchantParser

  attr_reader :file,
              :repository

  def initialize(file_path)
    @file = file_path
    @merchants = []
  end

  def load_csv
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      merchant_data = {:id => row[:id], :name => row[:name], :created_at => row[:created_at], :updated_at => row[:updated_at]}
      @merchants << merchant_data
    end
    @merchants
  end

end
