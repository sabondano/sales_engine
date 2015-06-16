class Merchant
  attr_reader :name, :created_at, :updated_at, :id, :repository

  def initialize(data, repository)
    @id = data[:id]
    @name = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = repository
  end
end