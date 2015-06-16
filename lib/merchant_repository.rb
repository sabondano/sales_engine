class MerchantRepository

  attr_reader :merchants,
              :sales_engine

  def initialize(data, sales_engine)
    @merchants = data
    @sales_engine = sales_engine
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

end
