class CustomerRepository
  attr_reader :sales_engine,
              :customers

  def initialize(data, sales_engine)
    @customers = data.map { |attributes| Customer.new(attributes, self) }
    @sales_engine = sales_engine
  end

  def inspect
    "#{self.class} #{@customers.size} rows"
  end

  def all
    customers
  end

  def random
    customers.sample
  end

  def find_by_id(id)
    customers.find do |customer|
      customer.id == id
    end
  end

  def find_by_first_name(first_name)
    customers.find do |customer|
      customer.first_name.downcase == first_name.downcase
    end
    end

  def find_by_last_name(last_name)
    customers.find do |customer|
      customer.last_name.downcase == last_name.downcase
    end
  end

  def find_by_created_at(created_at)
    customers.find do |customer|
      customer.created_at == created_at
    end
  end

  def find_by_updated_at(updated_at)
    customers.find do |customer|
      customer.updated_at == updated_at
    end
  end

  def find_all_by_id(id)
    customers.find_all do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(first_name)
    customers.find_all do |customer|
      customer.first_name.downcase == first_name.downcase
    end
  end

  def find_all_by_last_name(last_name)
    customers.find_all do |customer|
      customer.last_name.downcase == last_name.downcase
    end
  end

  def find_all_by_created_at(created_at)
    customers.find_all do |customer|
      customer.created_at == created_at
    end
  end

  def find_all_by_updated_at(updated_at)
    customers.find_all do |customer|
      customer.updated_at == updated_at
    end
  end
end
