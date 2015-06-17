require 'CSV'
require_relative 'transaction'

class TransactionParser

  attr_reader :file,
              :repository

  def initialize(file_path, repository)
    @file = file_path
    @transactions = []
    @repository = repository
  end

  def load_csv
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      transaction_data = {:id => row[:id], :invoice_id => row[:invoice_id], :credit_card_number => row[:credit_card_number], :credit_card_expiration_date => row[:credit_card_expiration_date], :result => row[:result], :created_at => row[:created_at], :updated_at => row[:updated_at]}
      @transactions << Transaction.new(transaction_data, repository)
    end
    @transactions
  end

end
