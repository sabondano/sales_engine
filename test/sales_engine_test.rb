require_relative 'test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_starts_up
    input_csv = fixture_path('merchants_fixture.csv')
    engine = SalesEngine.new(fixtures_directory)
    assert engine.startup
  end

  def test_it_can_access_merchant_repository
    input_csv = fixture_path('merchants_fixture.csv')
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    output = engine.merchant_repository.merchants[0].name
    expected = "Schroeder-Jerde"

    assert_equal expected, output
  end

  private

  def fixture_path(file_name)
    File.join(fixtures_directory, file_name)
  end

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end

end
