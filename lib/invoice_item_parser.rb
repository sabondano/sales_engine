require 'CSV'
require_relative 'invoice_item'

class InvoiceItemParser

  attr_reader :file,
              :repository

  def initialize(file_path, repository)
    @file = file_path
    @invoice_items = []
    @repository = repository
  end

  def load_csv
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      invoice_item_data = {:id => row[:id], :item_id => row[:item_id], :invoice_id => row[:invoice_id], :quantity => row[:quantity], :unit_price => row[:unit_price], :created_at => row[:created_at], :updated_at => row[:updated_at]}
      @invoice_items << InvoiceItem.new(invoice_item_data, repository)
    end
    @invoice_items
  end

end
