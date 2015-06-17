class InvoiceRepository
  attr_reader :invoices, :sales_engine

  def initialize(data, sales_engine)
    @invoices = data
    @sales_engine = sales_engine
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  def find_by_invoice_id(id)
    invoices.find do |invoice|
      invoice.id == id
    end
  end

  def find_by_customer_id(customer_id)
    invoices.find do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_by_merchant_id(merchant_id)
    invoices.find do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_by_status(status)
    invoices.find do |invoice|
      invoice.status == status
    end
  end

  def find_by_created_at(created_at)
    invoices.find do |invoice|
      invoice.created_at == created_at
    end
  end

  def find_by_updated_at(updated_at)
    invoices.find do |invoice|
      invoice.updated_at == updated_at
    end
  end

  def find_all_by_invoice_id(id)
    invoices.find_all do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    invoices.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def find_all_by_created_at(created_at)
    invoices.find_all do |invoice|
      invoice.created_at == created_at
    end
  end

  def find_all_by_updated_at(updated_at)
    invoices.find_all do |invoice|
      invoice.updated_at == updated_at
    end
  end

end