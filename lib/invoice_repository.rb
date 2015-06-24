class InvoiceRepository
  attr_reader :invoices,
              :sales_engine

  def initialize(data, sales_engine)
    @invoices = data.map { |attributes| Invoice.new(attributes, self) }
    @sales_engine = sales_engine
  end

  def inspect
    "#{self.class} #{@invoices.size} rows"
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  def find_by_id(id)
    invoices.find { |invoice| invoice.id == id }
  end

  def find_by_customer_id(customer_id)
    invoices.find { |invoice| invoice.customer_id == customer_id }
  end

  def find_by_merchant_id(merchant_id)
    invoices.find { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_by_status(status)
    invoices.find { |invoice| invoice.status == status }
  end

  def find_by_created_at(created_at)
    invoices.find { |invoice| invoice.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    invoices.find { |invoice| invoice.updated_at == updated_at }
  end

  def find_all_by_id(id)
    invoices.select { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(customer_id)
    invoices.select { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.select { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    invoices.select { |invoice| invoice.status == status }
  end

  def find_all_by_created_at(created_at)
    invoices.select do |i|
      i.created_at.strftime("%c %d, %Y") == created_at.strftime("%c %d, %Y")
    end
  end

  def find_all_by_updated_at(updated_at)
    invoices.select { |invoice| invoice.updated_at == updated_at }
  end

  def find_transactions(id)
    sales_engine.find_transactions_by_invoice_id(id)
  end

  def find_invoice_items(id)
    sales_engine.find_invoice_items_by_invoice_id(id)
  end

  def find_customer(customer_id)
    sales_engine.find_customer_by_customer_id(customer_id)
  end

  def find_merchant(id)
    sales_engine.find_merchant_by_invoice_id(id)
  end

  def find_items(invoice_id)
    sales_engine.find_items_by_invoice_id(invoice_id)
  end

  def create(invoice_data)
    customer = invoice_data[:customer]
    merchant = invoice_data[:merchant]
    status = invoice_data[:status]
    items = invoice_data[:items]
    new_invoice = Invoice.new({id: next_invoice_id,
                               customer_id: customer.id,
                               merchant_id: merchant.id,
                               status: status,
                               created_at: Time.now.strftime("%c %d, %Y"),
                               updated_at: Time.now.strftime("%c %d, %Y")},
                              self
                              )
    invoices << new_invoice
    sales_engine.create_invoice_items(items, new_invoice.id)
    new_invoice
  end

  def charge(payment_data, id)
    sales_engine.charge(payment_data, id)
  end

  private

  def next_invoice_id
    if invoices.last.nil?
      1
    else
      invoices.last.id.next
    end
  end
end
