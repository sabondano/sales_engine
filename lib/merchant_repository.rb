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
    merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant.name == name
    end
  end

  def find_by_created_at(created_at)
    merchants.find do |merchant|
      merchant.created_at == created_at
    end
  end

  def find_by_updated_at(updated_at)
    merchants.find do |merchant|
      merchant.updated_at == updated_at
    end
  end

  def find_all_by_id(id)
    merchants.find_all do |merchant|
      merchant.id == id
    end
  end

  def find_all_by_name(name)
    merchants.find_all do |merchant|
      merchant.name == name
    end
  end

  def find_all_by_created_at(created_at)
    merchants.find_all do |merchant|
      merchant.created_at == created_at
    end
  end

  def find_all_by_updated_at(updated_at)
    merchants.find_all do |merchant|
      merchant.updated_at == updated_at
    end
  end

  def find_items(id)
    sales_engine.find_items_by_merchant_id(id)
  end

  def find_invoices(id)
    sales_engine.find_invoices_by_merchant_id(id)
  end

  def most_revenue(x)
    merchants.sort_by { |merchant| merchant.revenue }.reverse[0..(x-1)]
  end
end
