require_relative 'item'

class ItemRepository
  attr_reader :sales_engine, :items

  def initialize(data, sales_engine)
    @items        = data.map { |attributes| Item.new(attributes, self) }
    @sales_engine = sales_engine
  end

  def inspect
    "#{self.class} #{@items.size} rows"
  end

  def all
    items
  end

  def random
    items.sample
  end

  def find_by_id(id)
    items.find { |item| item.id == id }
  end

  def find_by_name(name)
    items.find { |item| item.name.downcase == name.downcase }
  end

  def find_by_description(description)
    items.find { |item| item.description.downcase == description.downcase }
  end

  def find_by_unit_price(unit_price)
    items.find { |item| item.unit_price == unit_price }
  end

  def find_by_merchant_id(merchant_id)
    items.find { |item| item.merchant_id == merchant_id }
  end

  def find_by_created_at(created_at)
    items.find do |item|
      item.created_at.strftime("%c %d, %Y") == created_at.strftime("%c %d, %Y")
    end
  end

  def find_by_updated_at(updated_at)
    items.find do |item|
      item.updated_at.strftime("%c %d, %Y") == updated_at.strftime("%c %d, %Y")
    end
  end

  def find_all_by_id(id)
    items.select { |item| item.id == id }
  end

  def find_all_by_name(name)
    items.select { |item| item.name.downcase == name.downcase }
  end

  def find_all_by_description(description)
    items.select { |item| item.description.downcase == description.downcase }
  end

  def find_all_by_unit_price(unit_price)
    items.select { |item| item.unit_price == unit_price }
  end

  def find_all_by_merchant_id(merchant_id)
    items.select { |item| item.merchant_id == merchant_id }
  end

  def find_all_by_created_at(created_at)
    items.select do |item|
      item.created_at.strftime("%c %d, %Y") == created_at.strftime("%c %d, %Y")
    end
  end

  def find_all_by_updated_at(updated_at)
    items.select do |item|
      item.updated_at.strftime("%c %d, %Y") == updated_at.strftime("%c %d, %Y")
    end
  end

  def find_invoice_items(id)
    sales_engine.find_invoice_items_by_item_id(id)
  end

  def find_merchant(merchant_id)
    sales_engine.find_merchant_by_merchant_id(merchant_id)
  end

  def most_revenue(x)
    items.sort_by(&:revenue).reverse.first(x)
  end

  def most_items(x)
    items.sort_by(&:units_sold).reverse.first(x)
  end
end
