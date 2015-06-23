require_relative 'test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test
  attr_reader :customer_repository

  def setup
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    @customer_repository = engine.customer_repository
  end

  def test_customer_has_an_id
    data = { id: "1", first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:59 UTC" }
    repository = "merchant repo"

    customer = Customer.new(data, repository)

    assert_equal 1, customer.id
  end

  def test_customer_has_a_last_name
    data = { id: "1", first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:59 UTC" }
    repository = "merchant repo"

    customer = Customer.new(data, repository)

    assert_equal "Ondricka", customer.last_name
  end

  def test_finds_invoices_returns_all_invoices_for_associated_customer
    result_1 = @customer_repository.customers[0].invoices
    result_2 = @customer_repository.customers[5].invoices

    assert_equal 8, result_1.count
    assert_equal 0, result_2.count
  end

  def test_transactions_returns_all_transactions_assoc_with_customer
    result = @customer_repository.customers[0].transactions

    assert_equal 7, result.count
  end

  def test_favorite_merchant_returns_single_merchant_where_cust_has_most_no_of_successful_trans
    result = @customer_repository.customers[0].favorite_merchant

    assert_equal "Bechtelar, Jones and Stokes", result.name
  end

  private

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end
end
