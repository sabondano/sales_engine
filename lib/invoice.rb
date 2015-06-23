class Invoice
  attr_reader :created_at,
              :updated_at,
              :merchant_id,
              :customer_id,
              :id,
              :status,
              :repository

  def initialize(data, repository)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status]
    @created_at  = Date.parse data[:created_at]
    @updated_at  = data[:updated_at]
    @repository  = repository
  end

  def transactions
    @transactions ||= @repository.find_transactions(id)
  end

  def invoice_items
    @invoice_items ||= @repository.find_invoice_items(id)
  end

  def customer
    @customer ||= @repository.find_customer(customer_id)
  end

  def merchant
    @merchant ||= @repository.find_merchant(id)
  end

  def items
    invoice_items.map do |invoice_item|
      invoice_item.item
    end
  end

  def successful?
    transactions.any? do |transaction|
      transaction.successful?
    end
  end

  def total
    invoice_items.inject(0) do |total, invoice_item|
      total + (invoice_item.quantity * invoice_item.unit_price)
    end
  end
end
