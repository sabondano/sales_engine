class TransactionRepository
  attr_reader :transactions, :sales_engine

  def initialize(data, sales_engine)
    @transactions = data.map { |attributes| Transaction.new(attributes, self) }
    @sales_engine = sales_engine
  end

  def inspect
    "#{self.class} #{@transactions.size} rows"
  end

  def all
    transactions
  end

  def random
    transactions.sample
  end

  def find_by_id(id)
    transactions.find do |transaction|
      transaction.id == id
    end
  end

  def find_by_invoice_id(invoice_id)
    transactions.find do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_by_credit_card_number(credit_card_number)
    transactions.find do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    transactions.find do |transaction|
      transaction.credit_card_expiration_date == credit_card_expiration_date
    end
  end

  def find_by_result(result)
    transactions.find do |transaction|
      transaction.result == result
    end
  end

  def find_by_created_at(created_at)
    transactions.find do |transaction|
      transaction.created_at == created_at
    end
  end

  def find_by_updated_at(updated_at)
    transactions.find do |transaction|
      transaction.updated_at == updated_at
    end
  end

  def find_all_by_id(id)
    transactions.find_all do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    transactions.find_all do |transaction|
      transaction.credit_card_expiration_date == credit_card_expiration_date
    end
  end

  def find_all_by_result(result)
    transactions.find_all do |transaction|
      transaction.result == result
    end
  end

  def find_all_by_created_at(created_at)
    transactions.find_all do |transaction|
      transaction.created_at == created_at
    end
  end

  def find_all_by_updated_at(updated_at)
    transactions.find_all do |transaction|
      transaction.updated_at == updated_at
    end
  end
end
