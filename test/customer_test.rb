require_relative 'test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test
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
end
