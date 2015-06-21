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
      invoices_for_given_date = invoices.select { |i| Date.parse(i.created_at) == date }
      successful_transactions ||= invoices_for_given_date.map { |i| i.transactions }.flatten
      successful_transactions.select! { |t| t.result == 'success' }
      successful_invoices_for_given_date = successful_transactions.map { |t| t.invoice }
      successful_invoice_items_for_given_date = successful_invoices_for_given_date.map { |i| i.invoice_items }.flatten
      successful_invoice_items_for_given_date.reduce(0) do |revenue, invoice_item|
        revenue + (invoice_item.quantity * invoice_item.unit_price)
      end
    else
      successful_invoice_items =  successful_invoices.map { |i| i.invoice_items }.flatten
      successful_invoice_items.reduce(0) do |revenue, invoice_item|
        revenue + (invoice_item.quantity * invoice_item.unit_price)
      end
    end
  end

  private

  def successful_invoices
    successful_transactions ||= invoices.map { |i| i.transactions }.flatten
    successful_transactions.select! { |t| t.result == 'success' }
    invoices = successful_transactions.map { |t| t.invoice }
    invoices
  end
end
