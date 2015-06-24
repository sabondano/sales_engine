class MerchantRepository
  attr_reader :merchants,
              :sales_engine

  def initialize(data, sales_engine)
    @merchants = data.map { |attributes| Merchant.new(attributes, self) }
    @sales_engine = sales_engine
  end

  def inspect
    "#{self.class} #{@merchants.size} rows"
  end

  def all
    merchants
  end

  def random
    merchants.sample
  end

  def find_by_id(id)
    merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    merchants.find { |merchant| merchant.name == name }
  end

  def find_by_created_at(created_at)
    merchants.find {|merchant| merchant.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    merchants.find { |merchant| merchant.updated_at == updated_at }
  end

  def find_all_by_id(id)
    merchants.select { |merchant| merchant.id == id }
  end

  def find_all_by_name(name)
    merchants.select { |merchant| merchant.name == name }
  end

  def find_all_by_created_at(created_at)
    merchants.select { |merchant| merchant.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    merchants.select { |merchant| merchant.updated_at == updated_at }
  end

  def find_items(id)
    sales_engine.find_items_by_merchant_id(id)
  end

  def find_invoices(id)
    sales_engine.find_invoices_by_merchant_id(id)
  end

  def most_revenue(x)
    merchants.sort_by(&:revenue).reverse[0..(x - 1)]
  end

  def most_items(x)
    merchants.sort_by(&:items_sold).reverse[0..(x - 1)]
  end

  def find_customer(id)
    sales_engine.find_customer_by_customer_id(id)
  end

  def revenue(date)
    calculate_revenue(date)
  end

  def calculate_revenue(date)
    successful_invoices_for_date(date).inject(0) do |revenue, invoice|
      revenue + invoice.total
    end
  end

  private

  def invoices_for_date(date)
    sales_engine.find_invoices_by_date(date)
  end

  def transactions_for_date(date)
    invoices_for_date(date).map(&:transactions).flatten
  end

  def successful_transactions_for_date(date)
    transactions_for_date(date).select do |transaction|
      transaction.result == "success"
    end
  end

  def successful_invoices_for_date(date)
    successful_transactions_for_date(date).map(&:invoice)
  end
end
