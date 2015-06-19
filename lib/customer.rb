class Customer
  attr_reader :created_at,
              :last_name,
              :updated_at,
              :id,
              :first_name,
              :repository

  def initialize(data, repository)
    @id = data[:id].to_i
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = repository
  end

  def invoices
    @invoices ||= @repository.find_invoices(id)
  end
end
