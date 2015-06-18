class Merchant

  attr_reader :name,
              :created_at,
              :updated_at,
              :id,
              :repository

  def initialize(data, repository)
    @id = data[:id].to_i
    @name = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = repository
  end

  def items
    @items ||= @repository.find_items(id)
  end

  def invoices
    @invoices ||=@repository.find_invoices(id)
  end

end
