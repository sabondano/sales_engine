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

  private

  def successful_invoices(invoices)
    successful_transactions(invoices).select { |t| t.result == "success" }
        .map(&:invoice)
  end

  def successful_transactions(invoices)
    invoices.map(&:transactions).flatten
  end

  def successful_invoice_items(invoices)
    successful_invoices(invoices).map(&:invoice_items).flatten
  end

  def calculate_revenue_from_invoice_items(invoices)
    successful_invoice_items(invoices).inject(0) do |revenue, invoice_item|
      revenue + (invoice_item.quantity * invoice_item.unit_price)
    end
  end

  def find_invoices_by_date(date)
    invoices.select { |i| Date.parse(i.created_at) == date }
  end
end
