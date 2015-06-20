require 'csv'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'transaction'
require_relative 'transaction_repository'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'customer'
require_relative 'customer_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'item'
require_relative 'item_repository'
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

  def startup
    merchant_data = Parser.parse("#{@file_path}/merchants.csv")
    @merchant_repository = MerchantRepository.new(merchant_data, self)
    customer_data = Parser.parse("#{@file_path}/customers.csv")
    @customer_repository = CustomerRepository.new(customer_data, self)
    transaction_data = Parser.parse("#{@file_path}/transactions.csv")
    @transaction_repository = TransactionRepository.new(transaction_data, self)
    invoice_item_data = Parser.parse("#{@file_path}/invoice_items.csv")
    @invoice_item_repository = InvoiceItemRepository.new(invoice_item_data, self)
    item_data = Parser.parse("#{@file_path}/items.csv")
    @item_repository = ItemRepository.new(item_data, self)
    invoice_data = Parser.parse("#{@file_path}/invoices.csv")
    @invoice_repository = InvoiceRepository.new(invoice_data, self)
  end

  def find_items_by_merchant_id(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    invoice_repository.find_all_by_merchant_id(id)
  end

  def find_transactions_by_invoice_id(id)
    transaction_repository.find_all_by_invoice_id(id)
  end

  def find_invoice_items_by_invoice_id(id)
    invoice_item_repository.find_all_by_invoice_id(id)
  end

  def find_customer_by_customer_id(customer_id)
    customer_repository.find_by_id(customer_id)
  end

  def find_merchant_by_invoice_id(id)
    merchant_repository.find_by_id(id)
  end

  def find_items_by_invoice_id(id)
    find_invoice_items_by_invoice_id(id).select do |invoice_item|
      item_repository.find_by_id(invoice_item.item_id)
    end
  end

  def find_invoice_by_invoice_item_id(item_id)
    invoice_repository.find_by_id(item_id)
  end

  def find_item_by_item_id(item_id)
    item_repository.find_by_id(item_id)
  end

  def find_invoice_items_by_item_id(id)
    invoice_item_repository.find_all_by_item_id(id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    merchant_repository.find_by_id(merchant_id)
  end

  def find_invoice_by_transaction_id(id)
    invoice_repository.find_by_id(id)
  end

  def find_invoices_by_customer_id(id)
    invoice_repository.find_all_by_customer_id(id)
  end
end
