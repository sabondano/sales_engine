require 'csv'

module Parser
  def load_csv(file)
    CSV.open(file, headers: true, header_converters: :symbol)
  end
end
