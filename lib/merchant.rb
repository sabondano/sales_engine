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

  def revenue
    successful_invoice_items =  successful_invoices.map { |i| i.invoice_items }.flatten
    successful_invoice_items.reduce(0) do |revenue, invoice_item|
      revenue + (invoice_item.quantity * invoice_item.unit_price)
    end
  end

  private

  def successful_invoices
    successful_transactions ||= invoices.map { |i| i.transactions }.flatten
    successful_transactions.select! { |t| t.result == 'success'}
    invoices = successful_transactions.map { |t| t.invoice }
    invoices
  end
end
