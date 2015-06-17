require_relative 'test_helper'
require './lib/sales_engine'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository

  def setup
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    @item_repository = engine.item_repository
  end

  def test_it_has_a_sales_engine
    assert_equal "something", item_repository.items
  end

  private

  def fixture_path(file_name)
    File.join(fixtures_directory, file_name)
  end

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end
end