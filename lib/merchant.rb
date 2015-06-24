require 'date'

class Merchant
  attr_reader :name,
              :created_at,
              :updated_at,
              :id,
              :repository

  def initialize(data, repository)
    @id = data[:id].to_i
    @name = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = repository
  end

  def items
    @items ||= @repository.find_items(id)
  end

  def invoices
    @invoices ||= @repository.find_invoices(id)
  end

  def revenue(date=nil)
    if date.is_a?(Date)
      calculate_revenue_from_invoice_items(find_invoices_by_date(date))
    else
      calculate_revenue_from_invoice_items(invoices)
    end
  end

  def items_sold
    count_items_sold
  end

  def favorite_customer
    customer_id, invoices = successful_customers_hash.max_by do |key, value|
      value
    end
    @repository.find_customer(customer_id)
  end

  def unsuccessful_invoices
    invoices.reject do |invoice|
      invoice.transactions.any? { |transaction| transaction.successful? }
    end.flatten
  end

  def customers_with_pending_invoices
    unsuccessful_invoices.map(&:customer)
    #   invoice.customer
    # end
  end

  private

  def successful_invoices(invoices)
    transactions(invoices).select { |t| t.successful? }.map(&:invoice)
  end

  def transactions(invoices)
    invoices.flat_map(&:transactions)
  end

  def successful_invoice_items(invoices)
    successful_invoices(invoices).flat_map(&:invoice_items)
  end

  def calculate_revenue_from_invoice_items(invoices)
    successful_invoice_items(invoices).inject(0) do |revenue, invoice_item|
      revenue + (invoice_item.quantity * invoice_item.unit_price)
    end
  end

  def find_invoices_by_date(date)
    invoices.select { |i| i.created_at == date }
  end

  def count_items_sold
    successful_invoice_items(invoices).inject(0) do |total_units, invoice_item|
      total_units + invoice_item.quantity
    end
  end

  def successful_customers
    successful_invoices(invoices).map { |invoice| invoice.customer_id }
  end

  def successful_customers_hash
    successful_customers.reduce(Hash.new(0)) do |hash, customer_id|
      hash[customer_id] += 1
      hash
    end
  end
end
