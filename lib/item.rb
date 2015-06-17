require 'bigdecimal'

class Item
  attr_reader :name, :created_at, :unit_price, :updated_at, :merchant_id, :id, :description, :repository

  def initialize(data, repository)
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = (BigDecimal.new(data[:unit_price])/100).to_f
    @merchant_id = data[:merchant_id].to_i
    @created_at  = DateTime.strptime(data[:created_at], '%Y-%m-%d %H:%M:%S %Z')
    @updated_at  = DateTime.strptime(data[:updated_at], '%Y-%m-%d %H:%M:%S %Z')
    @repository  = repository
  end
end