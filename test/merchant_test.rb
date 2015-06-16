require_relative 'test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_merchant_has_an_id
    data = { id: "1", name: "Ace", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC" }
    repository = "merchant repo"

    merchant = Merchant.new(data, repository)

    assert_equal "1", merchant.id
  end

  def test_merchant_has_a_name
    data = { id: "1", name: "Ace", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC" }
    repository = "merchant repo"

    merchant = Merchant.new(data, repository)

    assert_equal "Ace", merchant.name
  end
end