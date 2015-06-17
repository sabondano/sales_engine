require 'CSV'
require_relative 'customer'

class CustomerParser
  attr_reader :file_path, :repository

  def initialize(file_path, repository)
    @file_path = file_path
    @customers = []
    @repository = repository
  end

  def load_csv
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      customer_data = {
          :id => row[:id],
          :first_name => row[:first_name],
          :last_name => row[:last_name],
          :created_at => row[:created_at],
          :updated_at => row[:updated_at]
      }

      @customers << Customer.new(customer_data, repository)
    end
    @customers
  end

end