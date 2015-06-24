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
    customers.find { |customer| customer.id == id }
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
    customers.find { |customer| customer.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    customers.find { |customer| customer.updated_at == updated_at }
  end

  def find_all_by_id(id)
    customers.select { |customer| customer.id == id }
  end

  def find_all_by_first_name(first_name)
    customers.select do |customer|
      customer.first_name.downcase == first_name.downcase
    end
  end

  def find_all_by_last_name(last_name)
    customers.select do |customer|
      customer.last_name.downcase == last_name.downcase
    end
  end

  def find_all_by_created_at(created_at)
    customers.select { |customer| customer.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    customers.select { |customer| customer.updated_at == updated_at }
  end

  def find_invoices(id)
    sales_engine.find_invoices_by_customer_id(id)
  end
end
