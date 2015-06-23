require 'bigdecimal'

class Item
  attr_reader :name,
              :created_at,
              :unit_price,
              :updated_at,
              :merchant_id,
              :id,
              :description,
              :repository

  def initialize(data, repository)
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = BigDecimal.new(data[:unit_price])/100
    @merchant_id = data[:merchant_id].to_i
    @created_at  = Date.parse(data[:created_at])
    @updated_at  = Date.parse(data[:created_at])
    @repository  = repository
  end

  def invoice_items
    @invoice_items ||= @repository.find_invoice_items(id)
  end

  def merchant
    @merchant ||= @repository.find_merchant(merchant_id)
  end

  def revenue
    @revenue ||= successful_invoice_items.inject(0) do |revenue, invoice_item|
      revenue + (invoice_item.quantity * invoice_item.unit_price)
    end
  end

  def units_sold
    @units_sold ||= successful_invoice_items.inject(0) do |units_sold, invoice_item|
      units_sold + invoice_item.quantity
    end
  end

  private

  def successful_invoice_items
    invoice_items.select(&:successful?)
  end
end
