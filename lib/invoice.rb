class Invoice
  attr_reader :created_at, :updated_at, :merchant_id, :customer_id, :id, :status, :repository

  def initialize(data, repository)
    @id = data[:id]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status      = data[:status]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @repository  = data[:repository]
  end
end