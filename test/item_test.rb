require_relative 'test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  def test_item_has_an_id
    item_data = { id: 1, name: 'Item Qui Esse', description: 'This is the description', unit_price: 75107, merchant_id: 1, created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC' }

    item = Item.new(item_data, 'repository')

    assert_equal 1, item.id
  end

  def test_item_has_a_name
    item_data = { id: 1, name: 'Item Qui Esse', description: 'This is the description', unit_price: 75107, merchant_id: 1, created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC' }

    item = Item.new(item_data, 'repository')

    assert_equal 'Item Qui Esse', item.name
  end
end

