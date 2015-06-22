require_relative 'test_helper'
require './lib/merchant'
require './lib/sales_engine'
require './lib/merchant_repository'

class MerchantTest < Minitest::Test

  attr_reader :merchant_repository

  def setup
    engine = SalesEngine.new(fixtures_directory)
    engine.startup
    @merchant_repository = engine.merchant_repository
  end

  def test_merchant_has_an_id
    data = { id: "1", name: "Ace", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC" }
    repository = "merchant repo"
    merchant = Merchant.new(data, repository)
    assert_equal 1, merchant.id
  end

  def test_merchant_has_a_name
    data = { id: "1", name: "Ace", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC" }
    repository = "merchant repo"
    merchant = Merchant.new(data, repository)
    assert_equal "Ace", merchant.name
  end

  def test_find_items_returns_items_associated_with_merchant
    result = @merchant_repository.merchants.first.items
    assert_equal 10, result.count
  end

  def test_find_invoices_returns_invoices_associated_with_merchant
    result = @merchant_repository.merchants[9].invoices
    assert_equal 2, result.count
  end

  def test_revenue_reports_all_revenue_for_a_merchant
    result = @merchant_repository.merchants[9].revenue
    assert_equal BigDecimal.new('1872.74'), result
  end

  def test_revenue_with_date_reports_all_revenue_for_that_date
    result = @merchant_repository.merchants[9].revenue('2012-03-24 15:54:10 UTC')
    assert_equal BigDecimal.new('1872.74'), result
  end

  def test_favorite_customer_returns_customer_with_most_successful_transactions
    result = @merchant_repository.merchants[9].favorite_customer
    assert_equal "Joey", result.first_name
  end

  def test_customers_with_pending_invoices_returns_collection_of_customers_with_unpaid_invoices
    load_data
    result = @se.merchant_repository.merchants[2].customers_with_pending_invoices
    assert_equal 0, result.count
  end

  private

  def fixtures_directory
    File.expand_path('../../data/fixtures', __FILE__)
  end

  def load_data
    repo_data = {
      merchants: [
       { id: 10, name: "merchant_1" },
       { id: 20, name: "merchant_2" },
       { id: 30, name: "merchant_3" }
     ],

       invoices: [
         { id: 1, merchant_id: 10, customer_id: 100, created_at: "2012-03-24" },
         { id: 2, merchant_id: 20, customer_id: 100, created_at: "2012-03-24" },
         { id: 3, merchant_id: 30, customer_id: 200, created_at: "2012-03-24" },
         { id: 4, merchant_id: 30, customer_id: 300, created_at: "2012-03-24" }
       ],
       transactions: [
       { id: 6, invoice_id: 1, result: "failed" },
       { id: 7, invoice_id: 2, result: "failed" },
       { id: 8, invoice_id: 3, result: "success" },
       { id: 9, invoice_id: 4, result: "failed" },
       { id: 0, invoice_id: 4, result: "success" }
     ],
      customers: [
        { id: 100, first_name: "Bob"},
        { id: 200, first_name: "Sebastian"},
        { id: 300, first_name: "Marla"}
      ]
    }
    @se = SalesEngine.new("fake_path")
    @se.init_repos(repo_data)
  end
end
