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
    init_repos merchants:      Parser.parse("#{@file_path}/merchants.csv"),
               customers:      Parser.parse("#{@file_path}/customers.csv"),
               transactions:   Parser.parse("#{@file_path}/transactions.csv"),
               invoice_items:  Parser.parse("#{@file_path}/invoice_items.csv"),
               items:          Parser.parse("#{@file_path}/items.csv"),
               invoices:       Parser.parse("#{@file_path}/invoices.csv")
  end

  def init_repos(repo_data)
    @merchant_repository     = MerchantRepository.
                                new(repo_data.fetch(:merchants, []), self)
    @customer_repository     = CustomerRepository.
                                new(repo_data.fetch(:customers, []), self)
    @transaction_repository  = TransactionRepository.
                                new(repo_data.fetch(:transactions, []), self)
    @invoice_item_repository = InvoiceItemRepository.
                                new(repo_data.fetch(:invoice_items, []), self)
    @item_repository         = ItemRepository.
                                new(repo_data.fetch(:items, []), self)
    @invoice_repository      = InvoiceRepository.
                                new(repo_data.fetch(:invoices, []), self)
  end

  def find_items_by_merchant_id(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    invoice_repository.find_all_by_merchant_id(id)
  end

  def find_transactions_by_invoice_id(invoice_id)
    transaction_repository.find_all_by_invoice_id(invoice_id)
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

  def find_invoices_by_date(date)
    invoice_repository.find_all_by_created_at(date)
  end

  def create_invoice_items(items, new_invoice_id)
    invoice_item_repository.create_invoice_items(items, new_invoice_id)
  end

  def charge(payment_data, invoice_id)
    transaction_repository.charge(payment_data, invoice_id)
  end
end
