require_relative 'item'

class ItemRepository
  attr_reader :sales_engine, :items

  def initialize(data, sales_engine)
    @items = data.map { |attributes| Item.new(attributes, self) }
    @sales_engine = sales_engine
  end
end