require 'bigdecimal'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id = data[:id]
    @item_id = data[:item_id]
    @invoice_id = data[:invoice_id]
    @quantity = data[:quantity]
    @unit_price = (BigDecimal.new(data[:unit_price])/100).to_f
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = repository
  end
end
