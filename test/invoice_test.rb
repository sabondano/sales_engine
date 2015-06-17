require_relative 'test_helper'
require './lib/invoice'

class InvoiceTest < Minitest::Test
  def test_invoice_has_an_id
    data = { id: "1", customer_id: "1", merchant_id: "Ondricka", status: "shipped", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:59 UTC" }
    repository = "merchant repo"

    invoice = Invoice.new(data, repository)

    assert_equal 1, invoice.id
  end

  def test_invoice_has_status
    data = { id: "1", customer_id: "1", merchant_id: "Ondricka", status: "shipped", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:59 UTC" }
    repository = "merchant repo"

    invoice = Invoice.new(data, repository)

    assert_equal "shipped", invoice.status
  end
end