class InvoiceParser
  attr_reader :file_path, :repository

  def initialize(file_path, repository)
    @file_path = file_path
    @invoices = []
    @repository = repository
  end

  def load_csv
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      invoice_data = {
          :id          => row[:id],
          :customer_id => row[:customer_id],
          :merchant_id => row[:merchant_id],
          :status      => row[:status],
          :created_at  => row[:created_at],
          :updated_at  => row[:updated_at]
      }

      @invoices << Invoice.new(invoice_data, repository)
    end
    @invoices
  end
end