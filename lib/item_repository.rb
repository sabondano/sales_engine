require_relative 'item'

class ItemRepository
  attr_reader :sales_engine, :items

  def initialize(data, sales_engine)
    @items = data.map { |attributes| Item.new(attributes, self) }
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
    items.find { |item| item.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    items.find { |item| item.updated_at == updated_at }
  end

  def find_all_by_id(id)
    items.find_all { |item| item.id == id }
  end

  def find_all_by_name(name)
    items.find_all { |item| item.name.downcase == name.downcase }
  end

  def find_all_by_description(description)
    items.find_all { |item| item.description.downcase == description.downcase }
  end

  def find_all_by_unit_price(unit_price)
    items.find_all { |item| item.unit_price == unit_price }
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all { |item| item.merchant_id == merchant_id }
  end

  def find_all_by_created_at(created_at)
    items.find_all { |item| item.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    items.find_all { |item| item.updated_at == updated_at }
  end

  def find_invoice_items(id)
    sales_engine.find_invoice_items_by_item_id(id)
  end

  def find_merchant(id)
    sales_engine.find_merchant_by_item_id(id)
  end
end