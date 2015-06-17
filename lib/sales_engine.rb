require 'csv'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'transaction'
require_relative 'transaction_repository'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'customer'
require_relative 'customer_repository'
require_relative 'parser'

class SalesEngine

  attr_reader :merchant_repository,
              :customer_repository,
              :transaction_repository,
              :invoice_item_repository,
              :invoice_repository,
              :item_repository

  def initialize(file_path)
    @file_path = file_path
  end
  #   pass in dir as an optional argument, if nothing is passed in use real data
  # @merchant_data = MerchantParser.new(file_path, ).load_csv
  # end

  def startup
    merchant_data = Parser.parse("#{@file_path}/merchants.csv")
    @merchant_repository = MerchantRepository.new(merchant_data, self)

    # @customer_repository = CustomerRepository.new(@file_path, self)
    # @transaction_repository = TransactionRepository.new(@file_path, self)
    # @invoice_item_repository = InvoiceItemRepository.new(@file_path, self)
    # @invoice_repository = InvoiceRepository.new(@file_path, self)
    # @item_repository = ItemRepository.new(@file_path, self)
  end

  # def parse(file_path)
  #   MerchantParser.new(file_path, self).load_csv
  # end

end
